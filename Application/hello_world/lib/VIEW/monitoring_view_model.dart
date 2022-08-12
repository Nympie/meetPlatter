import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hello_world/Domain/Repository/sensor_repository.dart';
import 'package:hello_world/VIEW/monitoring_event.dart';

import './monitoring_state.dart';


class MonitoringViewModel with ChangeNotifier {

  final SensorRepository _repository;
  var _state = MonitoringState();

  MonitoringState get state => _state;
  MonitoringViewModel(this._repository) {
    _getData();
  } // 외부에서 받아옴

  void onEvent(MonitoringEvent event) {
    event.when(query: _getData);
  }


  Future _getData() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _repository.getData();

    _state = state.copyWith(
      isLoading: false,
      data: result,
    );
    notifyListeners();
  }
}