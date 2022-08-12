import 'dart:convert';

import 'package:hello_world/Domain/Model/sensor_data.dart';
import 'package:hello_world/Data/Source/Remote/Bring_DHT.dart';
import 'package:hello_world/Domain/Repository/sensor_repository.dart';



class SensorRepositoryImpl implements SensorRepository {
  BringDHT api;

  SensorRepositoryImpl({required this.api});

  @override
  Future<List<Sensordata>> getPosts() async {
    final response = await api.getAllList();
    final Iterable json = jsonDecode(response.body);
    return json.map((e) => Sensordata.fromJson(e)).toList();
  }

  @override
  Future<List<Sensordata>> getData() {
    // TODO: implement getData
    throw UnimplementedError();
  }




}