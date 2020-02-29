import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/passed_parameters.dart';
import 'package:notes/models/add_or_edit.dart';
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
  GlobalVariables globalVariables;

  void initializeAddOrEditPages() {
    addOrEditPages = [
      {
        'page': Vidangee(),
        'route': Vidangee.route,
        'refKey': Constants.vidangePref
      },
      {
        'page': Courroie(),
        'route': Courroie.route,
        'refKey': Constants.courroiePref
      },
      {
        'page': Armortisseur(),
        'route': Armortisseur.route,
        'refKey': Constants.amortisseurPref
      },
      {
        'page': Batterie(),
        'route': Batterie.route,
        'refKey': Constants.batteriPref
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

  void navigateToEditItem({int index, BuildContext context}) async {
    globalVariables.dateViewIndex = index;
    pushResult = await navigateToAddOrEditPage(
        context: context, object: AddOrEditModelArgs(index: index));
    if (pushResult != null) list[pushResult['index']] = pushResult['element'];
  }

  void navigateToAddItem(BuildContext context) async {
    // set it to null because it decides to add new one when it null
    globalVariables.dateViewIndex = null;
    pushResult = await navigateToAddOrEditPage(context: context);
    if (pushResult != null) list.add(pushResult);
  }

  Future navigateToAddOrEditPage({BuildContext context, Object object}) {
    return Navigator.pushNamed(
        context, addOrEditPages[this.selectedMainViewElementIndex]['route'],
        arguments: object);
  }
}
//AddOrEditModelArgs(index: index)
