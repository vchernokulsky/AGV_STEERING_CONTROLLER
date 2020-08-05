import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:stm_setup/RobotSetUp.dart';

class CustomSwitch extends StatefulWidget {
  final String title;
  bool isSwitched = false;

  CustomSwitch({Key key, this.title, this.isSwitched}) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState(title, isSwitched);
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isSwitched = false;
  final String title;

  _CustomSwitchState(this.title, this.isSwitched);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(padding: EdgeInsets.all(5.0)),
      IntrinsicHeight(
          child: Row(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(5.0)),
          Expanded(child: Text(this.title, style: TextStyle(fontSize: 17))),
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
            activeTrackColor: Color(0x9fa4aeee),
            activeColor: Color(0xff6f80be),
          )
        ],
      )),
      Padding(padding: EdgeInsets.all(5.0)),
    ]);
  }
}
