import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:notes/screens/date_view.dart';

class MainViewLogic with ChangeNotifier {
  int index;

  void navigateToDateView(BuildContext context, int index) {
    this.index = index;
    notifyListeners();
    Navigator.pushNamed(context, DateView.route);
  }



}