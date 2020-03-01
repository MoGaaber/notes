import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/screens/date_view/date_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainViewLogic extends ChangeNotifier {
  List mainViewList = ['VIDANGE', 'COURROIE', 'AMORTISSEUR', 'BATTERIE'];

  MainViewLogic({BuildContext context}) {}
  void navigateToDateView({BuildContext context, int index}) {
    Provider.of<Globals>(context, listen: false).mainViewIndex = index;
    Navigator.pushNamed(context, DateView.route);
  }

//  MainLogic({@required SharedPreferences sharedPreferences}) {
//    futures = Future.wait([
//      sharedPreferences.setStringList(Constants.amortisseurPref, []),
//      sharedPreferences.setStringList(Constants.batteriPref, []),
//      sharedPreferences.setStringList(Constants.courroiePref, []),
//      sharedPreferences.setStringList(Constants.vidange, []),
//    ]);
//  }
/*  Future<List<bool>> futures;

  List list = [
    {'name': 'VIDANGE', 'sharedPreferencesKey': Constants.vidangePref},
    {'name': 'COURROIE', 'sharedPreferencesKey': Constants.courroiePref},
    {'name': 'AMORTISSEUR', 'sharedPreferencesKey': Constants.amortisseurPref},
//    {'name': 'FRIENAGE', 'sharedPrefKey': Constants.vidange},
    {'name': 'BATTERIE', 'sharedPreferencesKey': Constants.batteriPref}
  ];
*/

}
