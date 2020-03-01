import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/screens/add_or_edit/amortisseur.dart';
import 'package:notes/screens/add_or_edit/batterie.dart';
import 'package:notes/screens/add_or_edit/courroie.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:notes/screens/date_view/date_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateViewLogic extends ChangeNotifier {
  int index, selectedMainViewElementIndex, itemIndex;
  String pageRefKey;
  SharedPreferences sharedPreferences;
  List<Map> addOrEditPages;
  List list;
  var pushResult;
  Globals globalVariables;

  void initializeAddOrEditPages() {
    addOrEditPages = [
      {
        'page': Vidangee(),
        'route': Vidangee.route,
        'refKey': Constants.vidangePref,
        'name': 'VIDANGE'
      },
      {
        'page': Courroie(),
        'route': Courroie.route,
        'refKey': Constants.courroiePref,
        'name': 'COURROIE'
      },
      {
        'page': Armortisseur(),
        'route': Armortisseur.route,
        'refKey': Constants.amortisseurPref,
        'name': 'ARMORTISSEUR'
      },
      {
        'page': Batterie(),
        'route': Batterie.route,
        'refKey': Constants.batteriPref,
        'name': 'BATTERIE'
      }
    ];
  }

  DateViewLogic(
      {this.sharedPreferences,
      this.selectedMainViewElementIndex,
      BuildContext context}) {
    initializeAddOrEditPages();
    pageRefKey = addOrEditPages[selectedMainViewElementIndex]['refKey'];
    list = sharedPreferences.getStringList(pageRefKey);
    globalVariables = Provider.of(context, listen: false);
  }

  void deleteItem({int index}) {
    list.removeAt(index);
    sharedPreferences.setStringList(pageRefKey, list);
    notifyListeners();
  }

  void navigateToSave({int index, BuildContext context}) async {
    globalVariables.dateViewIndex = index;
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
    return Navigator.pushNamed(
      context,
      addOrEditPages[this.selectedMainViewElementIndex]['route'],
    );
  }
}
//AddOrEditModelArgs(index: index)
