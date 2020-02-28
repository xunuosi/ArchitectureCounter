import 'package:architecture_counter/bean.dart';
import 'package:architecture_counter/end_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SecondPage extends StatelessWidget {
  final CounterBean bean;
  final List<String> _tagList = ["后视点号", "后视距离", "后视黑面读数", "后视红面读数"];
  final List<FocusNode> _forcusNodeList = [null, FocusNode(), FocusNode(), FocusNode(), null];
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
              var item = new InputItem(Key(index.toString()), _tagList[index], _forcusNodeList[index], _forcusNodeList[index+1]);
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
                  handleNextAction(context);
                },
                color: Colors.lightBlue,
              ),
            );
          },
        ),
      ),
    );
  }

  void handleNextAction(BuildContext context) {
    bean.backPointNum = double.parse(_items[0].getInputValue());
    bean.backConstant = double.parse(_items[1].getInputValue());
    bean.backBlackNum = double.parse(_items[2].getInputValue());
    bean.backRedNum = double.parse(_items[3].getInputValue());

    var logger = Logger(
      printer: SimplePrinter(),
    );
    logger.d("Bean:%s", bean);

    var route = new MaterialPageRoute(
        builder: (BuildContext context) => new EndPage(bean: bean));
    Navigator.of(context).push(route);
  }
}

class InputItem extends StatefulWidget {
  final InputItemState _state;

  InputItem(Key key, String tag, FocusNode currentFocusNode, FocusNode nextFocusNode)
      : _state = new InputItemState(tag, currentFocusNode, nextFocusNode),
        super(key: key);

  String getInputValue() {
    return _state.getInputValue();
  }

  @override
  State<StatefulWidget> createState() {
    return _state;
  }
}

class InputItemState extends State<InputItem> {
  final String _tag;
  final TextEditingController _myController = new TextEditingController();
  final _currentFocusNode;
  final _nextFocusNode;

  InputItemState(this._tag, this._currentFocusNode, this._nextFocusNode);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _currentFocusNode.dispose();
    _nextFocusNode.dispose();
    _myController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 60.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this._tag,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.lightBlue),
          ),
          Expanded(
            child: TextField(
              controller: _myController,
              decoration: InputDecoration(hintText: "请输入"),
              textAlign: TextAlign.left,
              keyboardType: TextInputType.number,
              focusNode: _currentFocusNode,
              onSubmitted: (String text) => _nextFocusNode == null ? null : FocusScope.of(context).requestFocus(_nextFocusNode),
              textInputAction: _nextFocusNode == null ? TextInputAction.done : TextInputAction.next,
            ),
          )
        ],
      ),
    );
  }

  String getInputValue() {
    return _myController.text;
  }
}
