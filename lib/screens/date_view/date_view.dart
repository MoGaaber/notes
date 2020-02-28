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
  List addOrEditPages;
  String newElement;
  List editPages;
  List<Type> test;
  List hello = [Courroie(sharedPreferences: null)];
  int index;

  void init() {
    addOrEditPages = [
      Vidangee(
        sharedPreferences: widget.sharedPreferences,
        index: index,
      ),
      Courroie(sharedPreferences: widget.sharedPreferences),
      Armortisseur(
        sharedPreferences: widget.sharedPreferences,
      ),
      Batterie(sharedPreferences: widget.sharedPreferences)
    ];
  }

  @override
  void initState() {
    super.initState();
    init();
    list = widget.sharedPreferences.getStringList(widget.sharedPreferencesKey);

    editPages = [
      Vidangee(
        sharedPreferences: widget.sharedPreferences,
        edit: true,
      ),
      Courroie(
        sharedPreferences: widget.sharedPreferences,
      ),
      Armortisseur(
        sharedPreferences: widget.sharedPreferences,
      ),
      Batterie(sharedPreferences: widget.sharedPreferences)
    ];

    print('iam date view init stat');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            index = null;
            init();
            print(index);
            newElement = await Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    addOrEditPages[widget.index]));
            list = widget.sharedPreferences
                .getStringList(widget.sharedPreferencesKey);
          },
        ),
        body: list.length == 0
            ? Center(
                child: Text('not found any item here'),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  onTap: () {
                    this.index = index;
                    init();

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            addOrEditPages[widget.index],
                        settings: RouteSettings()));
                  },
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
