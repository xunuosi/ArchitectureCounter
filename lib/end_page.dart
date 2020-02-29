import 'package:architecture_counter/db/model/bean.dart';
import 'package:architecture_counter/second_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class EndPage extends StatelessWidget {
  final CounterBean bean;
  final List<String> _tagList = ["后视点号", "后视距离", "后视黑面读数", "后视红面读数"];
  final List<FocusNode> _forcusNodeList = [null, FocusNode(), FocusNode(), FocusNode(), null];
  final List<InputItem> _items = new List();

  EndPage({Key key, this.bean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("成水准手薄"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            if (index < 4) {
              var item = new InputItem(Key(index.toString()), _tagList[index], _forcusNodeList[index], _forcusNodeList[index+1]);
              _items.insert(index, item);
              return item;
            }
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 45),
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 45,
                    child: RaisedButton(
                      child: Text(
                        '继续输入',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                      onPressed: () {
                        resetAndSaveData(context);
                      },
                      color: Colors.lightBlue,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: RaisedButton(
                      child: Text(
                        '完成输入',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                      onPressed: () {
                        handleNextAction(context);
                      },
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void handleNextAction(BuildContext context) {
    bean.frontPointNum = double.parse(_items[0].getInputValue());
    bean.frontConstant = double.parse(_items[1].getInputValue());
    bean.frontBlackNum = double.parse(_items[2].getInputValue());
    bean.frontRedNum = double.parse(_items[3].getInputValue());

    var logger = Logger(
      printer: SimplePrinter(),
    );
    logger.d("Bean:%s", bean);


  }

  void resetAndSaveData(BuildContext context) {
    bean.frontPointNum = double.parse(_items[0].getInputValue());
    bean.frontConstant = double.parse(_items[1].getInputValue());
    bean.frontBlackNum = double.parse(_items[2].getInputValue());
    bean.frontRedNum = double.parse(_items[3].getInputValue());

  }
}
