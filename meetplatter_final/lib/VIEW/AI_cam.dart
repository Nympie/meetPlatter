import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meetplatter_final/VIEW/log_display.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'AI_result.dart';

class AIPageCam extends StatefulWidget {
  const AIPageCam({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<AIPageCam> createState() => _AIPageCamState();
}

class _AIPageCamState extends State<AIPageCam> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double ratio = 1.2;
    double ratio2 = 4 / 3;
    return Scaffold(
        appBar: AppBar(
          title: const Text('AI 진단'),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: SizedBox(
                  width: size.width / ratio,
                  height: size.width / ratio * ratio2,
                  child: FutureBuilder(
                      future: _initializeControllerFuture,
                      builder: (((context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return CameraPreview(_controller);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }))),
                ),
              ),
              const Spacer(),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 50,
                              color: Colors.lightGreenAccent,
                              spreadRadius: 1)
                        ]),
                    child: const CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      try {
                        await _initializeControllerFuture;
                        final path = join((await getTemporaryDirectory()).path,
                            '${DateTime.now()}.png');
                        XFile picture = await _controller.takePicture();
                        picture.saveTo(path);

                        if (path.isNotEmpty) {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      DisplayPictureScreen(imagePath: path)));
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    icon: const Icon(Icons.camera_alt_outlined),
                    iconSize: 70,
                    color: Colors.green[700],
                  )
                ],
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
