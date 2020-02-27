import 'package:flutter/material.dart';
import 'package:architecture_counter/second_page.dart';
import 'package:architecture_counter/first_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "成水准手薄",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}