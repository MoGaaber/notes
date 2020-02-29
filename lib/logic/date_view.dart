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
  int index;
  String sharedPreferencesKey;
  SharedPreferences sharedPreferences;
  List<Map> addOrEditPages;
  List list;
  var pushResult;
  int itemIndex;

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

  GlobalVariables globalVariables;
  String pageRef;
  int indexx;
  String sharedPrefKey;
  DateViewLogic(
      {this.sharedPreferences,
      this.indexx,
      this.sharedPreferencesKey,
      BuildContext context}) {
    initializeAddOrEditPages();
    pageRef = addOrEditPages[index]['refKey'];
    list = sharedPreferences.getStringList(sharedPreferencesKey);
    index = indexx;
    globalVariables = Provider.of(context, listen: false);
  }
  void navigateToAddItem(BuildContext context) async {
    // set it to null because it decides to add new one when it null
    globalVariables.dateViewIndex = null;
    pushResult = await pushToAddOrEditPage(context: context);
    sharedPreferences.setStringList(
        pageRef, sharedPreferences.getStringList(sharedPreferencesKey));
  }

  void deleteItem({int index}) {
    list.removeAt(index);
    sharedPreferences.setStringList(sharedPreferencesKey, list);
    notifyListeners();
  }

  void navigateToEditItem({int index, BuildContext context}) {
    pushToAddOrEditPage(
        context: context, object: AddOrEditModelArgs(index: index));
    globalVariables.dateViewIndex = index;
  }

  Future pushToAddOrEditPage({BuildContext context, Object object}) {
    return Navigator.pushNamed(context, addOrEditPages[this.index]['route'],
        arguments: object);
  }
}
//AddOrEditModelArgs(index: index)
