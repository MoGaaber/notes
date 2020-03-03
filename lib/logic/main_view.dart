import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/screens/date_view/date_view.dart';
import 'package:notes/screens/main_view/main_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainViewLogic extends ChangeNotifier {
  var path = 'assets/images';
  Globals globals;
  MainViewLogic(BuildContext context) {
    globals = Provider.of<Globals>(context, listen: false);
  }
  void navigateToDateView({BuildContext context, int index}) {
    Provider.of<Globals>(context, listen: false).mainViewIndex = index;
    Navigator.pushNamed(context, DateView.route);
  }
}
