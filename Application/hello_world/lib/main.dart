import 'package:flutter/material.dart';
import 'VIEW/Home.dart';


void main() {
  // runApp(const meetPlatter());
  runApp(
     const meetPlatter()
  );
}

class meetPlatter extends StatelessWidget {
  const meetPlatter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'meetPlatter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MyHomePage(title: 'meetPlatter'),
    );
  }
}

