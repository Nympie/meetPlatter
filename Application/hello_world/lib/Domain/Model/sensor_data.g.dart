// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Sensordata _$$_SensordataFromJson(Map<String, dynamic> json) =>
    _$_Sensordata(
      Temperature: json['Temperature'] as int,
      Humidity: json['Humidity'] as int,
      Time: json['Time'] as String,
    );

Map<String, dynamic> _$$_SensordataToJson(_$_Sensordata instance) =>
    <String, dynamic>{
      'Temperature': instance.Temperature,
      'Humidity': instance.Humidity,
      'Time': instance.Time,
    };
