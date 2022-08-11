import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AIPageCam extends StatefulWidget {
  const AIPageCam({Key? key}) : super(key: key);

  @override
  State<AIPageCam> createState() => _AI_camPageState();
}

class _AI_camPageState extends State<AIPageCam> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      color: Colors.amber,
    );
  }
}
