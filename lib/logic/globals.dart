import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/screens/add_or_edit/amortisseur.dart';
import 'package:notes/screens/add_or_edit/batterie.dart';
import 'package:notes/screens/add_or_edit/courroie.dart';
import 'package:notes/screens/add_or_edit/frenage.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:provider/provider.dart';

import 'add_or_edit.dart';

class Globals extends ChangeNotifier {
  int mainViewIndex, dateViewIndex;
  String sharedPrefKey;
  List<Map<String, dynamic>> addOrEditPages;
  int controllersLength;
  int yesNoLength;
  void initializeAddOrEditPages() {
    addOrEditPages = [
      {
        'controllersLength': 7,
        'yesNoLength': 4,
        'route': Vidangee.route,
        'refKey': Constants.vidangePref,
        'icon': 'oil.png',
        'name': 'VIDANGE'
      },
      {
        'controllersLength': 3,
        'yesNoLength': 0,
        'route': Courroie.route,
        'icon': 'motor.png',
        'refKey': Constants.courroiePref,
        'name': 'COURROIE'
      },
      {
        'controllersLength': 2,
        'yesNoLength': 2,
        'route': Armortisseur.route,
        'icon': 'damper.png',
        'refKey': Constants.amortisseurPref,
        'name': 'ARMORTISSEUR'
      },
      {
        'controllersLength': 2,
        'yesNoLength': 0,
        'route': Batterie.route,
        'icon': 'battery.png',
        'refKey': Constants.batteriPref,
        'name': 'BATTERIE'
      },
      {
        'controllersLength': 2,
        'yesNoLength': 4,
        'route': Freinage.route,
        'icon': 'brake.png',
        'refKey': Constants.frenagePref,
        'name': 'FREINAGE'
      },
    ];
  }

  Globals() {
    initializeAddOrEditPages();
  }
}
