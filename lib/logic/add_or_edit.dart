import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/date_view.dart';
import 'package:notes/screens/main_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart';

typedef SaveOperation = Function(List<String> list, String element);

class AddOrEditLogic with ChangeNotifier {
  Map<String, dynamic> decodedelement;
  SharedPreferences sharedPreferences;
  List<TextEditingController> controllers;
  List<bool> yesOrNo;
  var formKey = GlobalKey<FormState>();
  String date;
  List<VoidCallback> fetches;
  int mainViewIndex, dateViewIndex;
  SaveOperation saveOperation;
  Globals globals;
  bool isAdd;
  void initialize(int mainViewIndex, int dateViewIndex, bool isAdd) {
    this.dateViewIndex = dateViewIndex;
    this.mainViewIndex = mainViewIndex;
    this.isAdd = isAdd;
    controllers = List.generate(
        globals.addOrEditPages[mainViewIndex]['controllersLength'],
        (_) => TextEditingController());
    yesOrNo = List.filled(
        globals.addOrEditPages[mainViewIndex]['yesNoLength'], false);

    this.saveOperation = saveOperation;
    if (!this.isAdd) {
      fetches[mainViewIndex]();
    }
  }

  AddOrEditLogic(BuildContext context) {
    globals = Provider.of<Globals>(context, listen: false);
    this.sharedPreferences =
        Provider.of<SharedPreferences>(context, listen: false);
    date = DateFormat.yMd().format(DateTime.now());
    fetches = [
      fetchVidange,
      fetchCourroie,
      fetchAmortisseur,
      fetchBatterie,
      fetchFreinage
    ];
  }
  void fetchVidange() {
    decodedelement = jsonDecode(sharedPreferences
        .getStringList(SharedPrefKeys.vidangePref)[dateViewIndex]);

    date = decodedelement['Date'];
    controllers[0].text =
        decodedelement['KM'] == null ? null : decodedelement['KM'].toString();
    controllers[1].text = decodedelement['Next Oil Change'] == null
        ? null
        : decodedelement['Next Oil Change'].toString();
    controllers[2].text = decodedelement['Oil / Huile']['Price'] == null
        ? null
        : decodedelement['Oil / Huile']['Price'].toString();
    controllers[3].text = decodedelement['Air']['Price'] == null
        ? null
        : decodedelement['Air']['Price'].toString();
    controllers[4].text = decodedelement['Fuel / Carburant']['Price'] == null
        ? null
        : decodedelement['Fuel / Carburant']['Price'].toString();
    controllers[5].text = decodedelement['Clim']['Price'] == null
        ? null
        : decodedelement['Clim']['Price'].toString();
    yesOrNo[0] = decodedelement['Oil / Huile']['Excited'];
    yesOrNo[1] = decodedelement['Air']['Excited'];
    yesOrNo[2] = decodedelement['Fuel / Carburant']['Excited'];
    yesOrNo[3] = decodedelement['Clim']['Excited'];
  }

  void fetchBatterie() {
    decodedelement = jsonDecode(sharedPreferences
        .getStringList(SharedPrefKeys.batteriPref)[dateViewIndex]);
    this.date = decodedelement['Date'];
    controllers[0].text =
        decodedelement['KM'] == null ? null : decodedelement['KM'].toString();
    controllers[1].text = decodedelement['Note'].toString();
  }

  void fetchCourroie() {
    decodedelement = jsonDecode(sharedPreferences
        .getStringList(SharedPrefKeys.courroiePref)[dateViewIndex]);
    date = decodedelement['Date'];
    print(decodedelement);
    controllers[0].text =
        decodedelement['KM'] == null ? null : decodedelement['KM'].toString();
    controllers[1].text = decodedelement['Next Km'] == null
        ? null
        : decodedelement['KM'].toString();
    controllers[2].text = decodedelement['Note'];
  }

  void fetchAmortisseur() {
    decodedelement = jsonDecode(sharedPreferences
        .getStringList(SharedPrefKeys.amortisseurPref)[dateViewIndex]);
    print(decodedelement);
    this.date = decodedelement['Date'];
    controllers[0].text =
        decodedelement['KM'] == null ? null : decodedelement['KM'].toString();
    controllers[1].text = decodedelement['Note'];
    yesOrNo[0] = decodedelement['Front / AV'];
    yesOrNo[1] = decodedelement['Rear / AR'];
  }

  void fetchFreinage() {
    decodedelement = jsonDecode(sharedPreferences
        .getStringList(SharedPrefKeys.freinagePref)[dateViewIndex]);
    this.date = decodedelement['Date'];
    this.controllers[0].text =
        decodedelement['Disque de frein /Brake Disc']['KM'] == null
            ? null
            : decodedelement['Disque de frein /Brake Disc']['KM'].toString();
    this.controllers[1].text =
        decodedelement['Plaquette de frien /Brake Pad']['KM'] == null
            ? null
            : decodedelement['Plaquette de frien /Brake Pad']['KM'].toString();
    this.yesOrNo[0] =
        decodedelement['Disque de frein /Brake Disc']['Front / AV'];
    this.yesOrNo[1] =
        decodedelement['Disque de frein /Brake Disc']['Rear / AR'];
    this.yesOrNo[2] =
        decodedelement['Plaquette de frien /Brake Pad']['Front / AV'];
    this.yesOrNo[3] =
        decodedelement['Plaquette de frien /Brake Pad']['Rear / AR'];
  }

  void saveChanges({
    BuildContext context,
    String key,
    Map<String, dynamic> object,
  }) {
    var list = sharedPreferences.getStringList(key);
    String encodedElement = jsonEncode(object);
    if (this.isAdd) {
      list.add(encodedElement);
    } else {
      list[dateViewIndex] = encodedElement;
    }

    sharedPreferences.setStringList(key, list).then((x) {
      Navigator.pop(context, encodedElement);
    });
  }

  void showDatePick(BuildContext context) {
    showDatePicker(
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: Colors.orange,
                  accentColor: Colors.orange,
                  colorScheme: ColorScheme.light(primary: Colors.orange),
                  buttonTheme:
                      ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1500, 1, 1),
            lastDate: DateTime(2500, 1, 1))
        .then((dateTime) {
      if (dateTime != null) {
        date = DateFormat.yMd().format(dateTime);
        notifyListeners();
      }
    });
  }
}
