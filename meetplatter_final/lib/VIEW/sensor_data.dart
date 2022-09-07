import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'sensor_data.g.dart';

@JsonSerializable()
class Sensor {
  final int Humidity;
  final double Temperature;
  final String Time;
  final String Date;

  Sensor(
      {required this.Humidity,
      required this.Temperature,
      required this.Time,
      required this.Date});
  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);
  Map<String, dynamic> toJson() => _$SensorToJson(this);
}
