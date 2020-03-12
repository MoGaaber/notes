import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes/logic/globals.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateViewLogic extends ChangeNotifier {
  int mainViewIndex, dateViewIndex;

  String mKey;
  SharedPreferences sharedPreferences;
  List<String> list;
  var pushResult;
  Globals globals;
  Map mPage;
  String mRoute;
  void update(int mainViewIndex) {
    this.mainViewIndex = mainViewIndex;
    mPage = globals.addOrEditPages[mainViewIndex];
    mKey = mPage['refKey'];
    mRoute = mPage['route'];
    list = sharedPreferences.getStringList(mKey);
  }

  DateViewLogic(BuildContext context) {
    sharedPreferences = Provider.of<SharedPreferences>(context, listen: false);
    globals = Provider.of<Globals>(context, listen: false);
  }

  void updateItem({
    int index,
    BuildContext context,
  }) async {
    dateViewIndex = index;
    notifyListeners();
    var result = await Navigator.pushNamed(
        context, globals.addOrEditPages[mainViewIndex]['route']);

    if (result != null) {
      list[index] = result;
      notifyListeners();
    }
  }

  void addItem(BuildContext context) async {
    var result = await Navigator.pushNamed(
        context, globals.addOrEditPages[mainViewIndex]['route']);
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
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Delete confirmation'),
              content: Text('Are you sure ?!'),
              backgroundColor: Colors.white,
              actions: <Widget>[
                FlatButton(
                    child: Text('Yes'),
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
  }
}
//AddOrEditModelArgs(index: index)
