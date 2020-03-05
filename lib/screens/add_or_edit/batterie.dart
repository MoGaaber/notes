import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/utility/screen.dart';
import 'package:notes/widgets/date_chooser.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Batterie extends StatelessWidget {
  //controllers = List.generate(2, (_) => TextEditingController());
  static const String route = '/batterie';

  String date;
  @override
  Widget build(BuildContext context) {
    AddOrEditLogic addOrEditLogic =
        Provider.of<AddOrEditLogic>(context, listen: true);
    Globals globals = Provider.of<Globals>(context, listen: false);

    double height = globals.screen.height;
    double width = globals.screen.width;
    double aspectRatio = globals.screen.aspectRatio;
    double textScale = globals.screen.textScale;
    Screen screen = globals.screen;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 24 / aspectRatio * aspectRatio,
                ),
                onPressed: () {
                  if (addOrEditLogic.formKey.currentState.validate() &&
                      addOrEditLogic.date != null) {
                    BatterieModel batteriModel = BatterieModel(
                        date: addOrEditLogic.date,
                        km: num.parse(addOrEditLogic.controllers[0].text),
                        note: (addOrEditLogic.controllers[1].text));
                    addOrEditLogic.saveChanges(
                        key: SharedPrefKeys.batteriPref,
                        object: batteriModel.toJson(),
                        context: context);
                  }
                })
          ],
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/images/${globals.addOrEditPages[globals.mainViewIndex]['icon']}',
                color: Colors.white,
                width: screen.convert(50, width),
                height: screen.convert(30, height),
                fit: BoxFit.fitHeight,
              ),
              Text(globals.addOrEditPages[globals.mainViewIndex]['name'],
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        body: Form(
          key: addOrEditLogic.formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: globals.screen.convert(10, width)),
            children: <Widget>[
              DateChooser(
                addOrEditLogic: addOrEditLogic,
              ),
              for (int i = 0; i < 2; i++)
                Center(
                  child: MyTextField(
                    textFieldType: globals.addOrEditPages[3]['textFields'][i]
                        ['type'],
                    textEditingController: addOrEditLogic.controllers[i],
                    label: globals.addOrEditPages[3]['textFields'][i]['label'],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
