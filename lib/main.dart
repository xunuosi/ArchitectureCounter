import 'package:architecture_counter/db/manager/db_manager.dart';
import 'package:flutter/material.dart';
import 'package:architecture_counter/first_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initApp();
  runApp(MyApp());
}

void initApp() async {
  // Init db
  var now = new DateTime.now();
  var dbName = "tb" + now.year.toString() + now.month.toString() + now.day.toString();
  db_manager.initDatabase("counter_database.db", dbName);
}

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