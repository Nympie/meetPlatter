// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'package:json_annotation/json_annotation.dart';

part 'sensor_data.g.dart';

@JsonSerializable()
class Sensor {
  var Humidity;
  var Temperature;
  var Time;
  var Date;

  Sensor(
      {required this.Humidity,
      required this.Temperature,
      required this.Time,
      required this.Date});

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);

  Map<String, dynamic> toJson() => _$SensorToJson(this);
}
