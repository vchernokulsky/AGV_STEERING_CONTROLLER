import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectFromList extends StatefulWidget {
  final String title;
  final List<String> nameList;

  SelectFromList({Key key, this.title, this.nameList}) : super(key: key);

  _SelectFromList createState() => _SelectFromList(title, nameList);
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class _SelectFromList extends State<SelectFromList> {
  _SelectFromList(this.title, this.nameList);

  final String title;
  final List<String> nameList;
  List<ListItem> _dropdownItems = [];

  List<DropdownMenuItem<int>> _dropdownMenuItems;
  int _selectedItem;

  List<DropdownMenuItem<int>> buildDropDownMenuItems() {
    List<DropdownMenuItem<int>> items = List();
    for (int i = 0; i < nameList.length; i++) {
      items.add(
        DropdownMenuItem(
          child: Text(nameList[i]),
          value: i,
        ),
      );
    }
    return items;
  }

  void initState() {
    super.initState();
    _dropdownItems = [];
    for (int i = 0; i < nameList.length; i++) {
      _dropdownItems.add(ListItem(i, nameList[i]));
    }
    _dropdownMenuItems = buildDropDownMenuItems();
    _selectedItem = _dropdownMenuItems[0].value;
  }

  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
      child: Row(
        children: <Widget>[
          Center(
              child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Text('$title', style: TextStyle(fontSize: 18)))),
          DropdownButton<int>(
              value: _selectedItem,
              items: _dropdownMenuItems,
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                });
              }),

        ],
      ),
    ));
  }
}
