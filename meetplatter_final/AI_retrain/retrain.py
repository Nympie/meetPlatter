from datetime import datetime
import hashlib
import os.path
import random
import re
import sys
import tarfile

import numpy as np
from six.moves import urllib
import tensorflow as tf

from tensorflow.python.framework import graph_util
from tensorflow.python.platform import gfile
from tensorflow.python.util import compat

import os
os.environ["CUDA_VISIBLE_DEVICES"] = "-1"

DATA_URL = 'http://download.tensorflow.org/models/image/imagenet/inception-2015-12-05.tgz'
BOTTLENECK_TENSOR_NAME = 'pool_3/_reshape:0'
BOTTLENECK_TENSOR_SIZE = 2048
DEEP_LAYER_SIZE = 1024
JPEG_DATA_TENSOR_NAME = 'DecodeJpeg/contents:0'
RESIZED_INPUT_TENSOR_NAME = 'ResizeBilinear:0'
MAX_NUM_IMAGES_PER_CLASS = 2 ** 27 - 1

TRAINING_BATCH = 100
VALIDATION_BATCH = 100
TEST_BATCH = -1
VALIDATION_PERCENTAGE = 10
TEST_PERCENTAGE = 10

LEARNING_RATE = 0.01
EVAL_STEP = 10
NUMS_OF_TRAINNG_STEPS = 500
FINAL_TENSOR_NAME = 'Final_Result'

IMAGE_DIR = '/home/won/meetplatter_final/AI_retrain/images/lettuce'
MODEL_DIR = '/home/won/meetplatter_final/AI_retrain/model_dir'
BOTTLENECK_DIR = '/home/won/meetplatter_final/AI_retrain/bottleneck_dir'
SUMMARIES_DIR ='/home/won/meetplatter_final/AI_retrain/result/retrain_logs/graph'

OUTPUT_GRAPH = '/home/won/meetplatter_final/AI_retrain/result/graphs/output_graph45.pb'
OUTPUT_LABELS = '/home/won/meetplatter_final/AI_retrain/result/labels/output_labels45.txt'


def maybe_download_and_extract():
  dest_directory = MODEL_DIR
  if not os.path.exists(dest_directory):
    os.makedirs(dest_directory)
  filename = DATA_URL.split('/')[-1]
  filepath = os.path.join(dest_directory, filename)
  if not os.path.exists(filepath):
    def _progress(count, block_size, total_size):
      sys.stdout.write('\r>> Downloading %s %.1f%%' % (filename, float(count * block_size) / float(total_size) * 100.0))
      sys.stdout.flush()
    filepath, _ = urllib.request.urlretrieve(DATA_URL, filepath, _progress)
    print()
    statinfo = os.stat(filepath)
    print('Successfully downloaded', filename, statinfo.st_size, 'bytes.')
  tarfile.open(filepath, 'r:gz').extractall(dest_directory)



def create_inception_graph():
  with tf.Graph().as_default() as graph:
    model_filename = os.path.join(MODEL_DIR, 'classify_image_graph_def.pb')
    with gfile.FastGFile(model_filename, 'rb') as f:
      graph_def = tf.GraphDef()
      graph_def.ParseFromString(f.read())
      bottleneck_tensor, jpeg_data_tensor = (tf.import_graph_def(graph_def, name='', return_elements=[BOTTLENECK_TENSOR_NAME, JPEG_DATA_TENSOR_NAME]))
      
  return graph, bottleneck_tensor, jpeg_data_tensor



def create_image_lists(image_dir, testing_percentage, validation_percentage):
  if not gfile.Exists(image_dir):
    print("Image directory '" + image_dir + "' not found.")
    
    return None
  
  result = {}
  sub_dirs = [x[0] for x in gfile.Walk(image_dir)]
  is_root_dir = True
  
  for sub_dir in sub_dirs:
    if is_root_dir:
      is_root_dir = False
      continue
    
    extensions = ['jpg', 'jpeg', 'JPG', 'JPEG']
    file_list = []
    dir_name = os.path.basename(sub_dir)
    
    if dir_name == image_dir:
      continue
    
    print("Looking for images in '" + dir_name + "'")
    for extension in extensions:
      file_glob = os.path.join(image_dir, dir_name, '*.' + extension)
      file_list.extend(gfile.Glob(file_glob))
      
    if not file_list:
      print('No files found')
      continue
    
    if len(file_list) < 20:
      print('WARNING: Folder has less than 20 images, which may cause issues.')
    elif len(file_list) > MAX_NUM_IMAGES_PER_CLASS:
      print('WARNING: Folder {} has more than {} images. Some images will '
            'never be selected.'.format(dir_name, MAX_NUM_IMAGES_PER_CLASS))
      
    label_name = re.sub(r'[^a-z0-9]+', ' ', dir_name.lower())
    training_images = []
    testing_images = []
    validation_images = []
    
    for file_name in file_list:
      base_name = os.path.basename(file_name)
      hash_name = re.sub(r'_nohash_.*$', '', file_name)
      hash_name_hashed = hashlib.sha1(compat.as_bytes(hash_name)).hexdigest()
      percentage_hash = ((int(hash_name_hashed, 16) % (MAX_NUM_IMAGES_PER_CLASS + 1)) * (100.0 / MAX_NUM_IMAGES_PER_CLASS))
      if percentage_hash < validation_percentage:
        validation_images.append(base_name)
      elif percentage_hash < (testing_percentage + validation_percentage):
        testing_images.append(base_name)
      else:
        training_images.append(base_name)
    result[label_name] = {
        'dir': dir_name,
        'training': training_images,
        'testing': testing_images,
        'validation': validation_images,
    }
    
  return result


def get_image_path(image_lists, label_name, index, image_dir, category):
  if label_name not in image_lists:
    tf.logging.fatal('Label does not exist %s.', label_name)
  label_lists = image_lists[label_name]
  if category not in label_lists:
    tf.logging.fatal('Category does not exist %s.', category)
  category_list = label_lists[category]
  if not category_list:
    tf.logging.fatal('Label %s has no images in the category %s.', label_name, category)
  mod_index = index % len(category_list)
  base_name = category_list[mod_index]
  sub_dir = label_lists['dir']
  full_path = os.path.join(image_dir, sub_dir, base_name)
  
  return full_path



def run_bottleneck_on_image(sess, image_data, image_data_tensor, bottleneck_tensor):
  bottleneck_values = sess.run(bottleneck_tensor, {image_data_tensor: image_data})
  bottleneck_values = np.squeeze(bottleneck_values)
  
  return bottleneck_values


bottleneck_path_2_bottleneck_values = {}


def create_bottleneck_file(bottleneck_path, image_lists, label_name, index, image_dir, category, sess, jpeg_data_tensor, bottleneck_tensor):
  print('Creating bottleneck at ' + bottleneck_path)
  image_path = get_image_path(image_lists, label_name, index, image_dir, category)
  if not gfile.Exists(image_path):
    tf.logging.fatal('File does not exist %s', image_path)
  image_data = gfile.FastGFile(image_path, 'rb').read()
  
  try:
    bottleneck_values = run_bottleneck_on_image(
        sess, image_data, jpeg_data_tensor, bottleneck_tensor)
  except:
    raise RuntimeError('Error during processing file %s' % image_path)

  bottleneck_string = ','.join(str(x) for x in bottleneck_values)
  with open(bottleneck_path, 'w') as bottleneck_file:
    bottleneck_file.write(bottleneck_string)


def get_or_create_bottleneck(sess, image_lists, label_name, index, image_dir, category, bottleneck_dir, jpeg_data_tensor, bottleneck_tensor):
  label_lists = image_lists[label_name]
  sub_dir = label_lists['dir']
  sub_dir_path = os.path.join(bottleneck_dir, sub_dir)
  ensure_dir_exists(sub_dir_path)
  bottleneck_path = get_bottleneck_path(image_lists, label_name, index, bottleneck_dir, category)
  if not os.path.exists(bottleneck_path):
    create_bottleneck_file(bottleneck_path, image_lists, label_name, index, image_dir, category, sess, jpeg_data_tensor, bottleneck_tensor)

  with open(bottleneck_path, 'r') as bottleneck_file:
    bottleneck_string = bottleneck_file.read()
  did_hit_error = False
  try:
    bottleneck_values = [float(x) for x in bottleneck_string.split(',')]
  except ValueError:
    print('Invalid float found, recreating bottleneck')
    did_hit_error = True

  if did_hit_error:
    create_bottleneck_file(bottleneck_path, image_lists, label_name, index, image_dir, category, sess, jpeg_data_tensor, bottleneck_tensor)
    with open(bottleneck_path, 'r') as bottleneck_file:
      bottleneck_string = bottleneck_file.read()
    bottleneck_values = [float(x) for x in bottleneck_string.split(',')]
    
  return bottleneck_values


def cache_bottlenecks(sess, image_lists, image_dir, bottleneck_dir, jpeg_data_tensor, bottleneck_tensor):
  how_many_bottlenecks = 0
  ensure_dir_exists(bottleneck_dir)
  for label_name, label_lists in image_lists.items():
    for category in ['training', 'testing', 'validation']:
      category_list = label_lists[category]
      for index, unused_base_name in enumerate(category_list):
        get_or_create_bottleneck(sess, image_lists, label_name, index, image_dir, category, bottleneck_dir, jpeg_data_tensor, bottleneck_tensor)
        how_many_bottlenecks += 1
        if how_many_bottlenecks % 100 == 0:
          print(str(how_many_bottlenecks) + ' bottleneck files created.')


def get_random_cached_bottlenecks(sess, image_lists, how_many, category, bottleneck_dir, image_dir, jpeg_data_tensor, bottleneck_tensor):
  class_count = len(image_lists.keys())
  bottlenecks = []
  ground_truths = []
  filenames = []
  if how_many >= 0:
    for unused_i in range(how_many):
      label_index = random.randrange(class_count)
      label_name = list(image_lists.keys())[label_index]
      image_index = random.randrange(MAX_NUM_IMAGES_PER_CLASS + 1)
      image_name = get_image_path(image_lists, label_name, image_index, image_dir, category)
      bottleneck = get_or_create_bottleneck(sess, image_lists, label_name, image_index, image_dir, category, bottleneck_dir, jpeg_data_tensor, bottleneck_tensor)
      ground_truth = np.zeros(class_count, dtype=np.float32)
      ground_truth[label_index] = 1.0
      bottlenecks.append(bottleneck)
      ground_truths.append(ground_truth)
      filenames.append(image_name)
      
  else:
    for label_index, label_name in enumerate(image_lists.keys()):
      for image_index, image_name in enumerate(
          image_lists[label_name][category]):
        image_name = get_image_path(image_lists, label_name, image_index, image_dir, category)
        bottleneck = get_or_create_bottleneck(sess, image_lists, label_name, image_index, image_dir, category, bottleneck_dir, jpeg_data_tensor, bottleneck_tensor)
        ground_truth = np.zeros(class_count, dtype=np.float32)
        ground_truth[label_index] = 1.0
        bottlenecks.append(bottleneck)
        ground_truths.append(ground_truth)
        filenames.append(image_name)
        
  return bottlenecks, ground_truths, filenames


def get_bottleneck_path(image_lists, label_name, index, bottleneck_dir, category):
  
  return get_image_path(image_lists, label_name, index, bottleneck_dir, category) + '.txt'



def add_final_training_ops(class_count, final_tensor_name, bottleneck_tensor):
  with tf.name_scope('input'):
    X = tf.placeholder_with_default(bottleneck_tensor, shape=[None, BOTTLENECK_TENSOR_SIZE], 
                                    name='BottleneckInputPlaceholder')
    Y = tf.placeholder(tf.float32, [None, class_count], name='GroundTruthInput')
  
  with tf.name_scope('final_training_ops'):
    keep_prob = tf.placeholder_with_default(1.0, shape=[])
    with tf.name_scope('FClayer_1'):
      W1 = tf.get_variable("W1", shape=[BOTTLENECK_TENSOR_SIZE, DEEP_LAYER_SIZE], 
                           initializer=tf.contrib.layers.xavier_initializer())
      b1 = tf.Variable(tf.random_normal([DEEP_LAYER_SIZE]), name='b1')
      variable_summaries(W1)
      variable_summaries(b1)
      L1 = tf.nn.relu(tf.matmul(X, W1) + b1)
      L1 = tf.nn.dropout(L1, keep_prob=keep_prob)

    with tf.name_scope('FClayer_2'):    
      W2 = tf.get_variable("W2", shape=[DEEP_LAYER_SIZE, DEEP_LAYER_SIZE], 
                           initializer=tf.contrib.layers.xavier_initializer())
      b2 = tf.Variable(tf.random_normal([DEEP_LAYER_SIZE]), name='b2')
      variable_summaries(W2)
      variable_summaries(b2)
      L2 = tf.nn.relu(tf.matmul(L1, W2) + b2)
      L2 = tf.nn.dropout(L2, keep_prob=keep_prob)

    with tf.name_scope('FClayer_3'):
      W3 = tf.get_variable("W3", shape=[DEEP_LAYER_SIZE, DEEP_LAYER_SIZE], 
                           initializer=tf.contrib.layers.xavier_initializer())
      b3 = tf.Variable(tf.random_normal([DEEP_LAYER_SIZE]), name='b3')
      variable_summaries(W3)
      variable_summaries(b3)
      L3 = tf.nn.relu(tf.matmul(L2, W3) + b3)
      L3 = tf.nn.dropout(L3, keep_prob=keep_prob)

    with tf.name_scope('FClayer_4'):
      W4 = tf.get_variable("W4", shape=[DEEP_LAYER_SIZE, DEEP_LAYER_SIZE],
                           initializer=tf.contrib.layers.xavier_initializer())
      b4 = tf.Variable(tf.random_normal([DEEP_LAYER_SIZE]), name='b4')
      variable_summaries(W4)
      variable_summaries(b4)
      L4 = tf.nn.relu(tf.matmul(L3, W4) + b4)
      L4 = tf.nn.dropout(L4, keep_prob=keep_prob)

    with tf.name_scope('FClayer_final'):
      W5 = tf.get_variable("final_weight", shape=[DEEP_LAYER_SIZE, class_count], 
                           initializer=tf.contrib.layers.xavier_initializer())
      b5 = tf.Variable(tf.random_normal([class_count]), name='final_bias')
      variable_summaries(W5)
      variable_summaries(b5)
      logits = tf.matmul(L4, W5) + b5
      tf.summary.histogram('pre_activations', logits)
      
  final_tensor = tf.nn.softmax(logits, name=final_tensor_name)
  tf.summary.histogram('activations', final_tensor)

  with tf.name_scope('cross_entropy'):
    cross_entropy_mean = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(
        labels=Y, logits=logits))
    tf.summary.scalar('cross_entropy', cross_entropy_mean)

  with tf.name_scope('train'):
    optimizer = tf.train.GradientDescentOptimizer(LEARNING_RATE)
    train_step = optimizer.minimize(cross_entropy_mean)
    
  return (train_step, cross_entropy_mean, X, Y, final_tensor, keep_prob)


def add_evaluation_step(result_tensor, Y):
  with tf.name_scope('accuracy'):
    with tf.name_scope('correct_prediction'):
      prediction = tf.argmax(result_tensor, 1)
      correct_prediction = tf.equal(prediction, tf.argmax(Y, 1))
    with tf.name_scope('accuracy'):
      evaluation_step = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))
  tf.summary.scalar('accuracy', evaluation_step)
  
  return evaluation_step, prediction



def variable_summaries(var):
  with tf.name_scope('summaries'):
    mean = tf.reduce_mean(var)
    tf.summary.scalar('mean', mean)
    with tf.name_scope('stddev'):
      stddev = tf.sqrt(tf.reduce_mean(tf.square(var - mean)))
    tf.summary.scalar('stddev', stddev)
    tf.summary.scalar('max', tf.reduce_max(var))
    tf.summary.scalar('min', tf.reduce_min(var))
    tf.summary.histogram('histogram', var)


def ensure_dir_exists(dir_name):
  if not os.path.exists(dir_name):
    os.makedirs(dir_name)



if __name__ == '__main__':
  if tf.gfile.Exists(SUMMARIES_DIR):
    tf.gfile.DeleteRecursively(SUMMARIES_DIR)
  tf.gfile.MakeDirs(SUMMARIES_DIR)
  maybe_download_and_extract()
  graph, bottleneck_tensor, jpeg_data_tensor = (create_inception_graph())
  image_lists = create_image_lists(IMAGE_DIR, TEST_PERCENTAGE, VALIDATION_PERCENTAGE)

  
  
  with tf.Session(graph=graph) as sess:
    cache_bottlenecks(sess, image_lists, IMAGE_DIR, BOTTLENECK_DIR, jpeg_data_tensor, bottleneck_tensor)
    (train_step, cross_entropy, X, Y, final_tensor, keep_prob) = add_final_training_ops(len(image_lists.keys()), FINAL_TENSOR_NAME,bottleneck_tensor)
    evaluation_step, prediction = add_evaluation_step(final_tensor, Y)
    merged = tf.summary.merge_all()
    train_writer = tf.summary.FileWriter(SUMMARIES_DIR + '/train', sess.graph)
    validation_writer = tf.summary.FileWriter(SUMMARIES_DIR + '/validation')



    sess.run(tf.global_variables_initializer())
    for i in range(NUMS_OF_TRAINNG_STEPS):
      (train_bottlenecks,train_ground_truth, _) = get_random_cached_bottlenecks( sess, image_lists, TRAINING_BATCH, 'training', BOTTLENECK_DIR, IMAGE_DIR, jpeg_data_tensor, bottleneck_tensor)
      train_summary, _ = sess.run([merged, train_step], feed_dict={X: train_bottlenecks, Y: train_ground_truth, keep_prob:0.7})
      train_writer.add_summary(train_summary, i)



      is_last_step = (i + 1 == NUMS_OF_TRAINNG_STEPS)
      if (i % EVAL_STEP) == 0 or is_last_step:
        train_accuracy, cross_entropy_value = sess.run([evaluation_step, cross_entropy],feed_dict={X: train_bottlenecks, Y: train_ground_truth, keep_prob:1.0})
        print('%s: Step %d: Train accuracy = %.1f%%' % (datetime.now(), i, train_accuracy * 100))
        print('%s: Step %d: Cross entropy = %f' % (datetime.now(), i, cross_entropy_value))
        validation_bottlenecks, validation_ground_truth, _ = (
          get_random_cached_bottlenecks(sess, image_lists, VALIDATION_BATCH, 'validation', BOTTLENECK_DIR, IMAGE_DIR, jpeg_data_tensor, bottleneck_tensor))
        validation_summary, validation_accuracy = sess.run([merged, evaluation_step], feed_dict={X: validation_bottlenecks,Y: validation_ground_truth, keep_prob:1.0})
        validation_writer.add_summary(validation_summary, i)
        print('%s: Step %d: Validation accuracy = %.1f%% (N=%d)' % (datetime.now(), i, validation_accuracy * 100, len(validation_bottlenecks)))



    test_bottlenecks, test_ground_truth, test_filenames = (get_random_cached_bottlenecks(sess, image_lists, TEST_BATCH, 'testing', BOTTLENECK_DIR, IMAGE_DIR, jpeg_data_tensor, bottleneck_tensor))
    test_accuracy, predictions = sess.run([evaluation_step, prediction], feed_dict={X: test_bottlenecks, Y: test_ground_truth, keep_prob:1.0})
    print('Final test accuracy = %.1f%% (N=%d)' % (test_accuracy * 100, len(test_bottlenecks)))



    output_graph_def = graph_util.convert_variables_to_constants(sess, graph.as_graph_def(), [FINAL_TENSOR_NAME])
    with gfile.FastGFile(OUTPUT_GRAPH, 'wb') as f:
      f.write(output_graph_def.SerializeToString())
    with gfile.FastGFile(OUTPUT_LABELS, 'w') as f:
      f.write('\n'.join(image_lists.keys()) + '\n')