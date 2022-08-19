// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_world/Domain/Model/sensor_data.dart';
import 'package:http/retry.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MonitoringPageState createState() => _MonitoringPageState();
}

// class _MonitoringPageState extends State<MonitoringPage>
class _MonitoringPageState extends State<MonitoringPage> {
  Future<Sensor> fetchSensor() async {
    var url = Uri.parse('http://192.168.123.4:8081');
    var results = await http.get(url);
    print(results);
    if (results.statusCode == 200) {
      print('server is ok');
      // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
      return Sensor.fromJson(json.decode(results.body));
    } else {
      print('nooooo');
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('Failed to load post');
    }
  }

  late Future<Sensor> sensor;

  @override
  void initState() {
    super.initState();
    sensor = fetchSensor();
    print(sensor.runtimeType);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 're',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
          appBar: AppBar(title: const Text('qwe')),
          body: Center(
            child: FutureBuilder<Sensor>(
                future: sensor,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // ignore: avoid_print
                    return Text(snapshot.data!.Date);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ));
  }
}
