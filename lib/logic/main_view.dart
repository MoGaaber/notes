import 'package:flutter/material.dart';
import 'package:notes/models/date_view_args.dart';
import 'package:notes/screens/date_view.dart';

class MainViewLogic with ChangeNotifier {

  void navigateToDateView(BuildContext context, int index) {
    Navigator.pushNamed(context, DateView.route,arguments: DateViewArgs(index));
  }



}