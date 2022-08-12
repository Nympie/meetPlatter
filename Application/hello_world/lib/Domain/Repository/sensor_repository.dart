import '../Model/sensor_data.dart';

abstract class SensorRepository {
  Future<List<Sensordata>> getData();

}