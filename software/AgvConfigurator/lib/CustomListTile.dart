import 'package:flutter/material.dart';
import 'dart:typed_data';

class CustomListTile extends StatefulWidget {
  String subtitle;

  CustomListTile({Key key, this.subtitle}) : super(key: key);

  @override
  _CustomListTileState createState() => _CustomListTileState(this.subtitle);

  static String bytesToFirmwareVersion(Uint8List data){
    String ret = "";
    if(data.length == 3) {
      data.forEach((i) => ret += '$i.');
      ret = ret.substring(0, ret.length - 1);
    }
    return ret;
  }
}

class _CustomListTileState extends State<CustomListTile> {
  final String title = "Firmware version";
  String subtitle;

  _CustomListTileState (this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: Text(this.title, style: TextStyle(fontSize: 20)),
            subtitle: Text(this.subtitle, style: TextStyle(fontSize: 15))
        )
      ],
    );
  }
}