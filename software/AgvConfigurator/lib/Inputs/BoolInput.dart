import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataBool{
  bool data;
  DataBool(this.data);
}

class BoolInput extends StatefulWidget {
  final String title;
  final DataBool dataBool = DataBool(false);

  BoolInput({Key key, this.title}) : super(key: key);

  _BoolInput createState() => _BoolInput(title, dataBool);
}

class _BoolInput extends State<BoolInput> {
  _BoolInput(this.title, this.dataBool);

  final String title;
  final DataBool dataBool;

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        children: <Widget>[
          CustomSwitch(
            activeColor: Color(0xff2ada9a),
            value: dataBool.data,
            onChanged: (value) {
              print("VALUE : $value");
              setState(() {
                dataBool.data = value;
              });
            },
          ),
          Center(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text('$title', style: TextStyle(fontSize: 22)))),
        ],
      ),
    ));
  }
}