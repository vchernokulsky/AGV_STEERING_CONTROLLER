import 'package:flutter/material.dart';
import 'package:stm_setup/CustomListTile.dart';
import 'package:stm_setup/SocketData.dart';

class AboutDiffDrive extends StatefulWidget {
  AboutDiffDrive({Key key}) : super(key: key);

  @override
  _AboutDiffDriveState createState() => _AboutDiffDriveState();
}

class _AboutDiffDriveState extends State<AboutDiffDrive> {
  CustomListTile firmwareVersionTile;

  _AboutDiffDriveState() {
    firmwareVersionTile = CustomListTile(subtitle: "firmware version");
  }

  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    firmwareVersionTile.subtitle = SocketData.firmwareVersion;

    return Column(
      children: <Widget>[
      firmwareVersionTile,
        ]
    );
  }
}