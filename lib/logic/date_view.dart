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
  String pageRefKey;
  Animation<double> animation;
  AnimationController animationController;
  SharedPreferences sharedPreferences;
  List list;
  var pushResult;
  Globals globals;

  DateViewLogic({
    this.sharedPreferences,
    this.selectedMainViewElementIndex,
    BuildContext context,
  }) {
    globals = Provider.of(context, listen: false);
/*
    animationController = AnimationController(vsync: tickerProvider);
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
*/
    pageRefKey = globals.addOrEditPages[selectedMainViewElementIndex]['refKey'];
    list = sharedPreferences.getStringList(pageRefKey);
    if (list == null) {
      sharedPreferences.setStringList(pageRefKey, []);
    }
  }

  void deleteItem({int index}) {
    list.removeAt(index);
    sharedPreferences.setStringList(pageRefKey, list);
    notifyListeners();
  }

  void navigateToSave({int index, BuildContext context}) async {
    globals.dateViewIndex = index;
    pushResult = await navigateToAddOrEditPage(
      context: context,
    );

    if (pushResult != null) {
      if (index == null) {
        list.add(pushResult);
      } else {
        list[index] = pushResult;
      }
    }
  }

  Future navigateToAddOrEditPage({BuildContext context}) {
    print(selectedMainViewElementIndex);
    return Navigator.pushNamed(
      context,
      globals.addOrEditPages[this.selectedMainViewElementIndex]['route'],
    );
  }
}
//AddOrEditModelArgs(index: index)
