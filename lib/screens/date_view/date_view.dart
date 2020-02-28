import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/screens/add_or_edit/amortisseur.dart';
import 'package:notes/screens/add_or_edit/batterie.dart';
import 'package:notes/screens/add_or_edit/courroie.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateView extends StatefulWidget {
  SharedPreferences sharedPreferences;
  int index;
  String sharedPreferencesKey;
  DateView(
      {@required this.sharedPreferences,
      @required this.sharedPreferencesKey,
      @required this.index});
  @override
  _DateViewState createState() => _DateViewState();
}

class _DateViewState extends State<DateView> {
  List list;
  List<Widget> addOrEditPages;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.sharedPreferences.getStringList(widget.sharedPreferencesKey);
    addOrEditPages = [
      Vidangee(sharedPreferences: widget.sharedPreferences),
      Courroie(sharedPreferences: widget.sharedPreferences),
      Armortisseur(
        sharedPreferences: widget.sharedPreferences,
      ),
      Batterie(sharedPreferences: widget.sharedPreferences)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    addOrEditPages[widget.index]));
          },
        ),
        body: list.length == 0
            ? Center(
                child: Text('not found any item here'),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  title: Text(jsonDecode(list[index])['date']),
                  trailing: IconButton(
                    onPressed: () {
                      list.removeAt(index);
                      widget.sharedPreferences
                          .setStringList(widget.sharedPreferencesKey, list);
                      setState(() {});
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              ),
      ),
    );
  }
}
