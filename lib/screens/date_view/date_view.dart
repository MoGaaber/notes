import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/date_view.dart';
import 'package:notes/logic/passed_parameters.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/screens/add_or_edit/amortisseur.dart';
import 'package:notes/screens/add_or_edit/batterie.dart';
import 'package:notes/screens/add_or_edit/courroie.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateView extends StatelessWidget {
  static const String route = '/dateView';
  String sharedPreferencesKey;
  int index;

  @override
  Widget build(BuildContext context) {
    DateViewLogic dateViewLogic =
        Provider.of<DateViewLogic>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            dateViewLogic.navigateToAddItem(context);
          },
        ),
        body: dateViewLogic.list.length == 0
            ? Center(
                child: Text('not found any item here'),
              )
            : ListView.builder(
                itemCount: dateViewLogic.list.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  onTap: () {
                    dateViewLogic.navigateToEditItem(
                        context: context, index: index);
                  },
                  title: Text(jsonDecode(dateViewLogic.list[index])['date']),
                  trailing: IconButton(
                    onPressed: () {
                      dateViewLogic.deleteItem(index: index);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              ),
      ),
    );
  }
}
