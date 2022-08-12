import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sensor_data.freezed.dart';

part 'sensor_data.g.dart';

@freezed
class Sensordata with _$Sensordata {
  factory Sensordata({
    required int Temperature,
    required int Humidity,
    required String Time,

}) = _Sensordata;

  factory Sensordata.fromJson(Map<String, dynamic> json) => _$SensordataFromJson(json);
}