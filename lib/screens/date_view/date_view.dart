import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/date_view.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/screens/add_or_edit/amortisseur.dart';
import 'package:notes/screens/add_or_edit/batterie.dart';
import 'package:notes/screens/add_or_edit/courroie.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateView extends StatelessWidget {
  static const String route = '/dateView';
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    DateViewLogic dateViewLogic =
        Provider.of<DateViewLogic>(context, listen: true);
    Globals globals = Provider.of<Globals>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            dateViewLogic.addOrEditPages[globals.mainViewIndex]['name'],
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          elevation: 1,
          onPressed: () {
            dateViewLogic.navigateToSave(context: context, index: null);
          },
        ),
        body: dateViewLogic.list.length == 0
            ? Center(
                child: Text(
                  'Not found any item here',
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.separated(
                itemCount: dateViewLogic.list.length,
                itemBuilder: (BuildContext context, int index) => Dismissible(
                  direction: DismissDirection.startToEnd,
                  key: GlobalKey(debugLabel: index.toString()),
                  onDismissed: (x) {
                    dateViewLogic.deleteItem(index: index);
                  },
                  child: ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    ),
                    onTap: () {
                      dateViewLogic.navigateToSave(
                          context: context, index: index);
                    },
                    title: Text(
                      jsonDecode(dateViewLogic.list[index])['date'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) => Divider(
                  endIndent: 30,
                  height: 2,
                ),
              ),
      ),
    );
  }
}
