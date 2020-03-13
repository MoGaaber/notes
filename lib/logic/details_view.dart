import 'package:flutter/material.dart';
import 'package:notes/logic/globals.dart';

import 'add_or_edit.dart';

class DetailsViewLogic extends ChangeNotifier {
  int dateViewIndex, mainViewIndex;
  bool send = false;
  Map<String, dynamic> decodedData;
  SaveOperation saveOperation;
  void update(Map<String, dynamic> decodedData, int mainViewIndex, bool send) {
    this.send = send;
print(send);
    if (send) {
      this.mainViewIndex = mainViewIndex;
      this.decodedData = decodedData;
    }
  }
}
