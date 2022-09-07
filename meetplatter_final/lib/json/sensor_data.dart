import 'package:json_annotation/json_annotation.dart';

part 'sensor_data.g.dart';

@JsonSerializable()
class Sensor {
  final int AirCO2;
  final int AirHumidity;
  final double AirTemp;
  final int Lux;
  final String Time;
  final double WaterLevel;
  final double WaterTemp;
  final double pH;

  Sensor(
      {required this.AirCO2,
      required this.AirHumidity,
      required this.AirTemp,
      required this.Lux,
      required this.Time,
      required this.WaterLevel,
      required this.WaterTemp,
      required this.pH});

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);

  Map<String, dynamic> toJson() => _$SensorToJson(this);
}
