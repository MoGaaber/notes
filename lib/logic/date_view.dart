import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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

  void deleteItem({int index}) {
    list.removeAt(index);
    sharedPreferences.setStringList(mKey, list);
    notifyListeners();
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
