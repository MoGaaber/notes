import 'package:flutter/material.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/screens/date_view.dart';
import 'package:provider/provider.dart';

class MainViewLogic with ChangeNotifier {
  int index;
  void navigateToDateView(BuildContext context, int index) {
    this.index = index;
    notifyListeners();
    Navigator.pushNamed(context, DateView.route);
  }
}
