// ignore_for_file: camel_case_types

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'VIEW/Home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(meetPlatter(
    camera: firstCamera,
  ));
}

class meetPlatter extends StatelessWidget {
  const meetPlatter({super.key, required this.camera});
  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'meetPlatter Demo',
      theme: ThemeData(
          primarySwatch: Colors.green, backgroundColor: Colors.brown[400]),
      home: MyHomePage(
        title: 'meetPlatter',
        camera: camera,
      ),
    );
  }
}
