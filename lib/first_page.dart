import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:architecture_counter/bean.dart';
import 'package:flutter/material.dart';
import 'package:directory_picker/directory_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:architecture_counter/second_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _MyHomePage("成水准手薄");
  }
}

class _MyHomePage extends StatefulWidget {
  final String title;

  _MyHomePage(this.title);

  @override
  State<StatefulWidget> createState() => PathState(title);
}

class PathState extends State<_MyHomePage> {
  final String title;
  static const String KEY_PATH = "key_path";
  static const String DEFAULT_PATH = "/storage/emulated/0/archi_counter";
  Directory selectedDirectory;
  bool nextEnable = false;

  // 前尺输入值
  String frontValue = "";

  // 后尺输入值
  String backValue = "";

  PathState(this.title) {
    getSavePath();
  }

  Future<void> getSavePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String path = prefs.getString(KEY_PATH);
    if (path == null) {
      path = DEFAULT_PATH;
    }

    setState(() {
      selectedDirectory = new Directory(path);
    });

    savePath();
  }

  Future<bool> savePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KEY_PATH, selectedDirectory.path);
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
                height: 180,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.lightBlue),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "请输入",
                          labelText: "前尺常数",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.lightBlue,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          frontValue = text;
                          changeNextEnable();
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "请输入",
                          labelText: "后尺常数",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.lightBlue,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          backValue = text;
                          changeNextEnable();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                selectedDirectory != null
                    ? '导出路径: ' + selectedDirectory.path
                    : '导出路径: ',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: RaisedButton(
                child: Text(
                  '下一步',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
//                onPressed: () {
//                  nextEnable ? handleNextAction() : showToast("请检查数据是否输入完整");
//                },
                onPressed: nextEnable ? () => handleNextAction() : null,
                color: Colors.lightBlue,
                disabledColor: Colors.grey,
                disabledElevation: 0,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          onPressed: () => openFinder(),
          tooltip: "点击选择导出文件的路径",
          child: Icon(Icons.create_new_folder),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> openFinder() async {
    Directory root = new Directory('/storage/emulated/0/');
    Directory pickDir = await DirectoryPicker.pick(
      context: context,
      rootDirectory: root,
      allowFolderCreation: true,
    );

    setState(() {
      selectedDirectory = pickDir;
    });
  }

  void changeNextEnable() {
    bool enable = frontValue.length > 0 && backValue.length > 0;
    setState(() {
      nextEnable = enable;
    });
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.CENTER,
        fontSize: 12,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white);
  }

  void handleNextAction() async {
    // Save current path
    bool result = await savePath();
    print("Save path rs:" + result.toString());
    if (result) {
      CounterBean bean = new CounterBean();
      bean.frontConstant = double.parse('$frontValue');
      bean.backConstant = double.parse('$backValue');
      var logger = Logger(
        printer: SimplePrinter(),
      );
      logger.d("Bean:%s", bean);

      var route = new MaterialPageRoute(
          builder: (BuildContext context) => new SecondPage(bean: bean));
      Navigator.of(context).push(route);
      return;
    }
    showToast("存储路径失败请重新点击下一步");
  }
}
