// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitoring_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MonitoringState _$$_MonitoringStateFromJson(Map<String, dynamic> json) =>
    _$_MonitoringState(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Sensordata.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$_MonitoringStateToJson(_$_MonitoringState instance) =>
    <String, dynamic>{
      'data': instance.data,
      'isLoading': instance.isLoading,
    };
