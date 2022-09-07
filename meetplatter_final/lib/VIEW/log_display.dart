import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoggingDisplay extends StatefulWidget {
  const LoggingDisplay({super.key});

  @override
  State<LoggingDisplay> createState() => _LoggingDisplayState();
}

class _LoggingDisplayState extends State<LoggingDisplay> {
  Future<List<dynamic>> createDataList() async {
    Dio dio = Dio();
    var response = await dio.get("http://192.168.123.181:9090/log");
    var temp = [];
    temp = response.data['list'];
    return temp;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: createDataList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text('로그 테이블')),
          body: buildDataTable(snapshot.data!),
        );
      });

  Widget buildDataTable(List<dynamic> dataList) {
    final columns = ['시간', '온도', '습도', '조도', '탄소', '수온', '수위', 'pH'];

    return Scrollbar(
      scrollbarOrientation: ScrollbarOrientation.right,
      interactive: true,
      radius: const Radius.circular(10),
      thickness: 10,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: DataTable(
              columns: getColumns(columns),
              rows: getRows(dataList),
              headingRowColor: MaterialStateProperty.resolveWith(
                  (states) => Theme.of(context).colorScheme.background),
              border: const TableBorder(
                  verticalInside: BorderSide(color: Colors.white, width: 2)),
            )),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns
        .map((String column) => DataColumn(
                label: Expanded(
              child: Center(
                child: Text(
                  column,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            )))
        .toList();
  }

  List<DataRow> getRows(List<dynamic> dataList) => dataList.map((dynamic data) {
        return DataRow(cells: [
          DataCell(Center(child: Text('${data[0]}'))),
          DataCell(Center(child: Text('${data[1]}'))),
          DataCell(Center(child: Text('${data[2]}'))),
          DataCell(Center(child: Text('${data[3]}'))),
          DataCell(Center(child: Text('${data[4]}'))),
          DataCell(Center(child: Text('${data[5]}'))),
          DataCell(Center(child: Text('${data[6]}'))),
          DataCell(Center(child: Text('${data[7]}')))
        ]);
      }).toList();
}
