import 'dart:io';
import 'package:flutter/material.dart';
import 'package:meetplatter_final/json/results.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:meetplatter_final/json/variables.dart';

Future<dynamic> uploadImage(path) async {
  String fileName = path.split('/').last;
  FormData formData = FormData.fromMap({
    "file": await MultipartFile.fromFile(path, filename: fileName),
  });
  Dio dio = Dio();
  var response =
      await dio.post("http://192.168.123.181:9090/cam", data: formData);
  return jsonDecode(response.data);
}

class DisplayPictureScreen extends StatelessWidget {
  const DisplayPictureScreen({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double ratio = 1.2;
    double ratio2 = 4 / 3;
    return FutureBuilder(
        future: uploadImage(imagePath),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(
                            strokeWidth: 10,
                          )),
                      Padding(padding: EdgeInsets.all(50)),
                      Text(
                        "사진을 분석 중 입니다!\n잠시만 기다려주세요~",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.green,
                            shadows: [
                              Shadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                  offset: Offset(1.5, 1.5))
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            var results = Results.fromJson(snapshot.data);
            switcher(results);
            return Scaffold(
              appBar: AppBar(title: const Text('AI 진단 결과')),
              body: Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      const Spacer(),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 6,
                        child: SizedBox(
                          width: size.width / ratio,
                          height: size.width / ratio * ratio2,
                          child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.file(
                                File(imagePath),
                              )),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 3,
                        child: SizedBox(
                          width: size.width / ratio,
                          height: size.width / 2.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                '품종: $type ${results.type_prob}%',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[700],
                                    shadows: const [
                                      Shadow(
                                          color: Colors.grey,
                                          blurRadius: 5,
                                          offset: Offset(1.5, 1.5))
                                    ]),
                              ),
                              const Spacer(),
                              Text(
                                textAlign: TextAlign.center,
                                '생육 단계: $growth ${results.growth_prob}%',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[700],
                                    shadows: const [
                                      Shadow(
                                          color: Colors.grey,
                                          blurRadius: 5,
                                          offset: Offset(1.5, 1.5))
                                    ]),
                              ),
                              const Spacer(),
                              Text(
                                textAlign: TextAlign.center,
                                '건강 상태: $health ${results.health_prob}%',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[700],
                                    shadows: const [
                                      Shadow(
                                          color: Colors.grey,
                                          blurRadius: 5,
                                          offset: Offset(1.5, 1.5))
                                    ]),
                              ),
                              const Spacer(),
                              Text(
                                textAlign: TextAlign.center,
                                '신선도: $freshness ${results.freshness_prob}%',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[700],
                                    shadows: const [
                                      Shadow(
                                          color: Colors.grey,
                                          blurRadius: 5,
                                          offset: Offset(1.5, 1.5))
                                    ]),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  void switcher(results) {
    if (results.type == "b'redleaf\\n'") {
      type = "적상추";
    } else if (results.type == "b'romaine\\n'") {
      type = "로메인 상추";
    } else if (results.type == "b'greenleaf\\n'") {
      type = "청상추";
    }
    if (results.growth == "b'seedling\\n'") {
      growth = "묘목";
    } else {
      growth = "성목";
    }
    if (results.health == "b'healthy\\n'") {
      health = "건강함";
    } else {
      health = "병걸림";
    }
    if (results.freshness == "b'rotten\\n'") {
      freshness = "썩음";
    } else {
      freshness = "신선함";
    }
  }
}
