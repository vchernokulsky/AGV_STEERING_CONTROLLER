import 'dart:io';

import 'package:flutter/material.dart';

import 'CustomListTile.dart';
import 'SocketData.dart';


class AboutDiffDrive extends StatefulWidget {
  final SocketData socketData;
  final TextEditingController controller = TextEditingController();
  AboutDiffDrive({Key key, this.socketData}) : super(key: key);

  @override
  _AboutDiffDriveState createState() => _AboutDiffDriveState(socketData, controller);
}

class _AboutDiffDriveState extends State<AboutDiffDrive> {
  final SocketData socketData;
  final controller;

  String title = "";

  _AboutDiffDriveState(this.socketData, this.controller);

  void initState() {
    super.initState();
    socketData.addListener(updateState);
    socketData.getFirmwareVersion();
  }
  void updateState() {
//    setState(() {
//
//    });
  }
  @override
  Widget build(BuildContext context) {
    controller.text = SocketData.firmwareVersion;
    return Column(
      children: <Widget>[
        Center(
            child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Firmware version', style: TextStyle(fontSize: 20)))),
        TextField(
          controller: controller,
          enabled: false,
          decoration: InputDecoration(
            labelText: "",
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.text,
          onSubmitted: (text) {},
        ),
        ]
    );
  }
}