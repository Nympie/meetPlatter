// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sensor _$SensorFromJson(Map<String, dynamic> json) => Sensor(
      Humidity: json['Humidity'] as int,
      Temperature: (json['Temperature'] as num).toDouble(),
      Time: json['Time'] as String,
      Date: json['Date'] as String,
    );

Map<String, dynamic> _$SensorToJson(Sensor instance) => <String, dynamic>{
      'Humidity': instance.Humidity,
      'Temperature': instance.Temperature,
      'Time': instance.Time,
      'Date': instance.Date,
    };