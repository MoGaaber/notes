import 'package:flutter/material.dart';

import 'add_or_edit.dart';

class DetailsViewLogic extends ChangeNotifier {
  int dateViewIndex, mainViewIndex;
  bool send = false;
  Map<String, dynamic> decodedData;
  SaveOperation saveOperation;

  void initialize(
      Map<String, dynamic> decodedData, int dateViewIndex, int mainViewIndex) {
    this.dateViewIndex = dateViewIndex;
    this.decodedData = decodedData;
    this.mainViewIndex = mainViewIndex;
  }
}
