import numpy as np
import tensorflow as tf
import os
os.environ["CUDA_VISIBLE_DEVICES"] = "-1"                                

class AI_Diagnosis():
    
    def __init__(self, InputImage):
        self.InputImage = InputImage
        self.graph_path = []
        self.label_path = []
        self.graph_group = []
        self.predictionz = []
        self.count = 0
        self.total = 0
        self.result = []
        self.bpath = os.path.dirname("/home/won/meetplatter_final/AI_inference/results/output_graph1.pb")
        self.answer = ""
        self.probability = float

    def create_graph(self, j):
        with tf.gfile.FastGFile(self.graph_path[j], 'rb') as f:
            graph_def = tf.GraphDef()
            graph_def.ParseFromString(f.read())
            _ = tf.import_graph_def(graph_def, name='')
            
    def run_inference_on_image(self, labels):
        if self.InputImage:
                with tf.Session() as sess:
                    softmax_tensor = sess.graph.get_tensor_by_name('Final_Result:0')
                    predictions = sess.run(softmax_tensor, feed_dict={'DecodeJpeg/contents:0': self.InputImage})

                    self.predictionz += predictions
                    
                    print(predictions)
                    print(self.predictionz)
                    
                    self.count += 1
                    
                    if self.count % 5 == 0:
                        self.predictionz = np.squeeze(self.predictionz)
                        a = self.predictionz.tolist()
                        top_1 = self.predictionz[self.predictionz.argsort()][-1:][::-1]
                        idx = a.index(top_1)
                        answer = labels[idx]
                        for i in range(len(a)):
                            self.total += a[i]
                        probability = self.predictionz[idx] / self.total
                        self.total = 0
                        self.result.append(answer)
                        self.result.append(probability)

    def result_of_inference(self,num):
        for i in range(num):
            self.label_path.append(self.bpath+"/output_labels"+str(i+1)+".txt")
            f = open(self.label_path[i], 'rb')
            lines = f.readlines()
            labels = [str(w).replace("\n","") for w in lines]
            self.predictionz = np.zeros([1, len(labels)])
            
            for j in range(5):
                self.graph_path.append(self.bpath+"/output_graph"+str(i+1)+str(j+1)+".pb")
                print(labels)
                print(self.graph_path[self.count])
                self.create_graph(self.count)
                self.graph_group.append(tf.get_default_graph())
                with self.graph_group[self.count].as_default():
                    self.run_inference_on_image(labels)
                tf.reset_default_graph()
            
            
    def toJson(self, result):
        json_dict = dict(type=result[0], type_prob=int(result[1]*100), growth=result[2], growth_prob=int(result[3]*100), health=result[4], health_prob=int(result[5]*100), freshness=result[6], freshness_prob=int(result[7]*100))
        return json_dict