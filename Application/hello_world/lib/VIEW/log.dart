import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:meetplatter_final/json/log_data.dart';

class LoggingDisplay extends StatefulWidget {
  const LoggingDisplay({super.key});

  @override
  State<LoggingDisplay> createState() => _LoggingDisplayState();
}

class _LoggingDisplayState extends State<LoggingDisplay> {
  late var resultz;

  @override
  void initState() {
    super.initState();
    var sensorDataList = createDataList();

    resultz = sensorDataList;
  }

  Future<List<String>> createDataList() async {

    Dio dio = Dio();
    var response = await dio.get("http://192.168.123.181:9090/log");
    var temp = [];
    temp = response.data['list'];
    for (int i = 0; i < temp.length; i++) {
      Hour.add(temp[i][0].toString());
      Air_Temp.add((temp[i][1]).toString());
      Air_Humi.add((temp[i][2]).toString());
      Brightness.add((temp[i][3]).toString());
      Co2.add((temp[i][4]).toString());
      Water_Temp.add((temp[i][5]).toString());
      Water_Levl.add((temp[i][6]).toString());
      pH.add((temp[i][7]).toString());
    }
    sensorDataList.addAll(Hour);
    sensorDataList.addAll(Air_Temp);
    sensorDataList.addAll(Air_Humi);
    sensorDataList.addAll(Brightness);
    sensorDataList.addAll(Co2);
    sensorDataList.addAll(Water_Temp);
    sensorDataList.addAll(Water_Levl);
    sensorDataList.addAll(pH);
    print(sensorDataList);
    return sensorDataList;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: createDataList(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(title: const Text('로그')),
          body: buildDataTable(),
        );
      });

  Widget buildDataTable() {
    final columns = ['시간', '온도', '습도', '조도', '탄소', '수온', '수위', 'pH'];

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        // child: DataTable(columns: getColumns(columns), rows: getRows(resultz)),
        child: DataTable(columns: getColumns(columns), rows: [
          DataRow(cells: [
            DataCell(Text('')),
            DataCell(Text('text')),
            DataCell(Text('text')),
            DataCell(Text('text')),
            DataCell(Text('text')),
            DataCell(Text('text')),
            DataCell(Text('text')),
            DataCell(Text('text'))
          ])
        ]),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns
        .map((String column) => DataColumn(
                label: Text(
              column,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )))
        .toList();
  }

  List<DataRow> getRows(List<String> resultz) => resultz.map((String result) {
        final cells = [
          result[0],
          result[1],
          result[2],
          result[3],
          result[4],
          result[5],
          result[6],
          result[7]
        ];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();
}