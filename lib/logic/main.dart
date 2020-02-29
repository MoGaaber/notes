import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/passed_parameters.dart';
import 'package:notes/models/date_view.dart';
import 'package:notes/screens/date_view/date_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainLogic extends ChangeNotifier {
  List list = [
    {'name': 'VIDANGE', 'sharedPreferencesKey': Constants.vidangePref},
    {'name': 'COURROIE', 'sharedPreferencesKey': Constants.courroiePref},
    {'name': 'AMORTISSEUR', 'sharedPreferencesKey': Constants.amortisseurPref},
//    {'name': 'FRIENAGE', 'sharedPrefKey': Constants.vidange},
    {'name': 'BATTERIE', 'sharedPreferencesKey': Constants.batteriPref}
  ];
  SharedPreferences sharedPreferences;
  Future<List<bool>> futures;
  void navigateToDateView({BuildContext context, int index}) {
    GlobalVariables globalVariables =
        Provider.of<GlobalVariables>(context, listen: false);
    globalVariables.mainViewindex = index;
    globalVariables.sharedPrefKey = list[index]['sharedPreferencesKey'];
    Navigator.pushNamed(context, DateView.route,
        arguments: DateViewModelArg(
            index: index,
            sharedPreferencesKey: list[index]['sharedPreferencesKey']));
  }

  MainLogic() {
    print('hello');
  }

//  MainLogic({@required SharedPreferences sharedPreferences}) {
//    futures = Future.wait([
//      sharedPreferences.setStringList(Constants.amortisseurPref, []),
//      sharedPreferences.setStringList(Constants.batteriPref, []),
//      sharedPreferences.setStringList(Constants.courroiePref, []),
//      sharedPreferences.setStringList(Constants.vidange, []),
//    ]);
//  }
}
