import 'package:flutter/material.dart';
import 'package:notes/logic/globals.dart';

class DetailsViewLogic extends ChangeNotifier {
  int dateViewIndex, mainViewIndex;
  Map<String, dynamic> decodedData;
  Globals globals;
  void update(Map<String, dynamic> decodedData, int mainViewIndex) {
    this.mainViewIndex = mainViewIndex;
    this.decodedData = decodedData;
  }
}
