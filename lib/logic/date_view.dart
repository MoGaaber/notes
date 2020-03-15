import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/add_edit_args.dart';
import 'package:notes/models/details_view_args.dart';
import 'package:notes/screens/details_view.dart';
import 'package:notes/utility/screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_or_edit.dart';

class DateViewLogic extends ChangeNotifier {
  bool send = false;
  int mainViewIndex, dateViewIndex;
  List<TextEditingController> controllers;
  List<bool> yesOrNo;

  String mKey;
  SharedPreferences sharedPreferences;
  List<String> list;
  var pushResult;
  Globals globals;
  Map mPage;
  String mRoute;

  DateViewLogic(BuildContext context) {
    sharedPreferences = Provider.of<SharedPreferences>(context, listen: false);
    globals = Provider.of<Globals>(context, listen: false);
  }

  void updateItem({
    int dateViewIndex,
    BuildContext context,
  }) async {
    var result = await Navigator.pushNamed(
        context, globals.addOrEditPages[mainViewIndex]['route'],
        arguments:
            AddOrEditArgs(false, mainViewIndex, dateViewIndex: dateViewIndex));
    if (result != null) {
      list[dateViewIndex] = result;
      notifyListeners();
    }
  }

  void initialize(int mainViewIndex) {
    this.mainViewIndex = mainViewIndex;
    mPage = globals.addOrEditPages[mainViewIndex];
    mKey = mPage['refKey'];
    mRoute = mPage['route'];
    list = sharedPreferences.getStringList(mKey);
  }

  SaveOperation saveOperation;

  void addItem(BuildContext context) async {
    var result = await Navigator.pushNamed(
        context, globals.addOrEditPages[mainViewIndex]['route'],
        arguments: AddOrEditArgs(true, this.mainViewIndex,
            dateViewIndex: this.dateViewIndex));
    if (result != null) {
      list.add(result);
    }
  }

  void deleteItem({int index, BuildContext context}) async {
    list.removeAt(index);
    await sharedPreferences.setStringList(mKey, list);
    Navigator.pop(context);
    notifyListeners();
  }

  void showDeleteAlertDialog(int index, BuildContext context) {
    Globals globals = Provider.of<Globals>(context, listen: false);
    double height = globals.screen.height;
    Screen screen = globals.screen;
    double width = globals.screen.width;

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Row(
                children: <Widget>[
                  Icon(
                    Icons.not_interested,
                    color: Colors.red,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screen.convert(4, width))),
                  Text(
                    'Delete confirmation',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              content: Text('Are you sure ? '),
              backgroundColor: Colors.white,
              actions: <Widget>[
                FlatButton(
                    child: Text(
                      'Yes !',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    textColor: Colors.orange,
                    onPressed: () async {
                      deleteItem(index: index, context: context);
                    }),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No'),
                  textColor: Colors.orange,
                )
              ],
            ));
  }

  void showItemDetails(int dateViewIndex, BuildContext context) async {
    Map<String, dynamic> decodedData = jsonDecode(list[dateViewIndex]);

    var result = await Navigator.pushNamed(context, DetailsView.route,
        arguments:
            DetailsViewArgs(decodedData, dateViewIndex, this.mainViewIndex));

    if (result != null) {
      list[dateViewIndex] = jsonEncode(result);
      notifyListeners();
    }
  }

  void update(List<String> list, String element) {
    list[dateViewIndex] = element;
  }
}

void add(List<String> list, String element) {
  list.add(element);
}

//AddOrEditModelArgs(index: index)
/*
  void navigateToSave({int index, BuildContext context}) async {
    this.dateViewIndex = index;
    notifyListeners();
    pushResult = await Navigator.pushNamed(
      context,
      mRoute,
    );
    if (pushResult != null) {
      if (index == null) {
        list.add(pushResult);
      } else {
        list[index] = pushResult;
      }

      notifyListeners();
    }
  }*/
