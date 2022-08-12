import 'package:freezed_annotation/freezed_annotation.dart';

part 'monitoring_event.freezed.dart';

//MonitoringEvent class 를 사용할 때 실수를 줄일 수 있도록 클래스 안의 타입만 가능하도록 만듦

@freezed
class MonitoringEvent<T> with _$MonitoringEvent<T> {
  const factory MonitoringEvent.query() = Query;
}