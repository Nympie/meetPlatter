// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sensor _$SensorFromJson(Map<String, dynamic> json) => Sensor(
      AirCO2: json['AirCO2'] as int,
      AirHumidity: json['AirHumidity'] as int,
      AirTemp: (json['AirTemp'] as num).toDouble(),
      Lux: json['Lux'] as int,
      Time: json['Time'] as String,
      WaterLevel: (json['WaterLevel'] as num).toDouble(),
      WaterTemp: (json['WaterTemp'] as num).toDouble(),
      pH: (json['pH'] as num).toDouble(),
    );

Map<String, dynamic> _$SensorToJson(Sensor instance) => <String, dynamic>{
      'AirCO2': instance.AirCO2,
      'AirHumidity': instance.AirHumidity,
      'AirTemp': instance.AirTemp,
      'Lux': instance.Lux,
      'Time': instance.Time,
      'WaterLevel': instance.WaterLevel,
      'WaterTemp': instance.WaterTemp,
      'pH': instance.pH,
    };
