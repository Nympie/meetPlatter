// ignore_for_file: file_names

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'monitoring.dart';
import 'AI_cam.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.camera});

  final String title;
  final CameraDescription camera;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Flexible(
              fit: FlexFit.tight,
              flex: 6,
              child: Container(
                width: size.width,
                height: size.width / 5 * 4,
                child: Image.asset(
                  'assets/home.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const Spacer(),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Container(
                width: size.width,
                child: Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: size.width / 5 * 2,
                      height: size.width / 3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shadowColor: Colors.greenAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => MonitoringPage()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.monitor,
                                size: size.width / 6,
                              ),
                              Padding(
                                  padding: EdgeInsets.all(size.width / 200)),
                              const Text(
                                '모니터링\n및 제어',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 13),
                              )
                            ],
                          )),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: size.width / 5 * 2,
                      height: size.width / 3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shadowColor: Colors.greenAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => AIPageCam(
                                          camera: widget.camera,
                                        )));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.content_paste,
                                size: size.width / 6,
                              ),
                              Padding(
                                  padding: EdgeInsets.all(size.width / 100)),
                              const Text(
                                'AI 진단',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              )
                            ],
                          )),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
