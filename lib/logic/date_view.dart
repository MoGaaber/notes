import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/screens/add_or_edit/amortisseur.dart';
import 'package:notes/screens/add_or_edit/batterie.dart';
import 'package:notes/screens/add_or_edit/courroie.dart';
import 'package:notes/screens/add_or_edit/frenage.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:notes/screens/date_view/date_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateViewLogic extends ChangeNotifier {
  int index, selectedMainViewElementIndex, itemIndex;
  String mKey;
  Animation<double> animation;
  AnimationController animationController;
  SharedPreferences sharedPreferences;
  List<String> list;
  var pushResult;
  Globals globals;
  Map mPage;
  String mRoute;
  DateViewLogic({
    this.sharedPreferences,
    this.selectedMainViewElementIndex,
    BuildContext context,
  }) {
    globals = Provider.of(context, listen: false);
    mPage = globals.addOrEditPages[selectedMainViewElementIndex];
    mKey = mPage['refKey'];
    mRoute = mPage['route'];
    print('date view construcot');
    list = sharedPreferences.getStringList(mKey);
  }

  void deleteItem({int index}) {
    list.removeAt(index);
    sharedPreferences.setStringList(mKey, list);
    notifyListeners();
  }

  void navigateToSave({int index, BuildContext context}) async {
    globals.dateViewIndex = index;
    pushResult = await Navigator.pushNamed(
      context,
      mRoute,
    );
    print(pushResult);

    if (pushResult != null) {
      if (list == null) list = [];

      if (index == null) {
        list.add(pushResult);

        print('1555555');
      } else {
        list[index] = pushResult;
      }

      notifyListeners();
    }
  }
}
//AddOrEditModelArgs(index: index)
