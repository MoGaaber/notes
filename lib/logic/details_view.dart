import 'package:flutter/material.dart';
import 'package:notes/logic/globals.dart';

import 'add_or_edit.dart';

class DetailsViewLogic extends ChangeNotifier {
  int dateViewIndex, mainViewIndex;
  Map<String, dynamic> decodedData;
  SaveOperation saveOperation;
  void update(Map<String, dynamic> decodedData, int mainViewIndex) {
    if (this.mainViewIndex != mainViewIndex) {
      this.mainViewIndex = mainViewIndex;
    }
    if (this.decodedData != decodedData) {
      this.decodedData = decodedData;
    }
  }
}
