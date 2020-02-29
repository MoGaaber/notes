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
  var newElement;
  int itemIndex;

  void init() {
    addOrEditPages = [
      {'page': Vidangee(), 'route': Vidangee.route},
      {'page': Courroie(), 'route': Courroie.route},
      {'page': Armortisseur(), 'route': Armortisseur.route},
      {'page': Batterie(), 'route': Batterie.route}
    ];
  }

  int indexx;
  String sharedPrefKey;
  DateViewLogic(
      {this.sharedPreferences, this.indexx, this.sharedPreferencesKey}) {
    init();
    list = sharedPreferences.getStringList(sharedPreferencesKey);
    index = indexx;
  }
  void navigateToAddItem(BuildContext context) async {
    GlobalVariables globalVariables = Provider.of(context, listen: false);
    globalVariables.dateViewIndex = null;

    itemIndex = null;
    newElement = await Navigator.pushNamed(
      context,
      addOrEditPages[index]['route'],
    );
    list = sharedPreferences.getStringList(sharedPreferencesKey);
  }

  void deleteItem({int index}) {
    list.removeAt(index);
    sharedPreferences.setStringList(sharedPreferencesKey, list);
    notifyListeners();
  }

  void navigateToEditItem({int index, BuildContext context}) {
    Navigator.pushNamed(context, addOrEditPages[this.index]['route'],
        arguments: AddOrEditModelArgs(index: index));
  }
}
