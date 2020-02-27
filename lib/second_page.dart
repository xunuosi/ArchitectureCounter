import 'package:architecture_counter/bean.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SecondPage extends StatelessWidget {
  final CounterBean bean;
  final List<String> _tagList = ["后视点号", "后视距离", "后视黑面读数", "后视红面读数"];
  final List<InputItem> _items = new List();

  SecondPage({Key key, this.bean}) : super(key: key);

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
              var item = new InputItem(Key(index.toString()), _tagList[index]);
              _items.insert(index, item);
              return item;
            }
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RaisedButton(
                child: Text(
                  '下一步',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                onPressed: () {
                  handleNextAction();
                },
                color: Colors.lightBlue,
              ),
            );
          },
        ),
      ),
    );
  }

  void handleNextAction() {
    bean.backPointNum = double.parse(_items[0].getInputValue());
    bean.backConstant = double.parse(_items[1].getInputValue());
    bean.backBlackNum = double.parse(_items[2].getInputValue());
    bean.backRedNum = double.parse(_items[3].getInputValue());

    var logger = Logger(
      printer: SimplePrinter(),
    );
    logger.d("Bean:%s", bean);
  }
}

class InputItem extends StatelessWidget {
  final String tag;
  final myController = TextEditingController();

  InputItem(Key key, this.tag) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 60.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.tag,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.lightBlue),
          ),
          Expanded(
            child: TextField(
              controller: myController,
              decoration: InputDecoration(hintText: "请输入"),
            ),
          )
        ],
      ),
    );
  }

  String getInputValue() {
    return myController.text;
  }
}
