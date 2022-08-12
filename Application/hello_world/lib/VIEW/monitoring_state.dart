import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../Domain/Model/sensor_data.dart';

part 'monitoring_state.freezed.dart';

part 'monitoring_state.g.dart';

@freezed
class MonitoringState with _$MonitoringState {
  factory MonitoringState({
    @Default([]) List<Sensordata> data,
    @Default(false) bool isLoading,
}) = _MonitoringState;

  factory MonitoringState.fromJson(Map<String, dynamic> json) => _$MonitoringStateFromJson(json);
}