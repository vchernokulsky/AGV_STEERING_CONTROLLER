import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoolInput extends StatefulWidget {
  final String title;

  BoolInput({Key key, this.title}) : super(key: key);

  _BoolInput createState() => _BoolInput(title);
}

class _BoolInput extends State<BoolInput> {
  _BoolInput(this.title);

  final String title;
  bool status;

  void initState() {
    super.initState();
    status = false;
  }

  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        children: <Widget>[
          CustomSwitch(
            activeColor: Colors.pinkAccent,
            value: status,
            onChanged: (value) {
              print("VALUE : $value");
              setState(() {
                status = value;
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
