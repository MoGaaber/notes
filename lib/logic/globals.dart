import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'add_or_edit.dart';

class Globals extends ChangeNotifier {
  int mainViewIndex, dateViewIndex;
  String sharedPrefKey;
}
