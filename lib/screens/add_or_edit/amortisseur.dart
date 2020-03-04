import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/amortisseur.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/widgets/date_chooser.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Armortisseur extends StatelessWidget {
  static const String route = '/armortisseur';
//  controllers = List.generate(2, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    AddOrEditLogic addOrEditLogic =
        Provider.of<AddOrEditLogic>(context, listen: true);
    Globals globals = Provider.of<Globals>(context, listen: false);

    double height = globals.screen.height;
    double width = globals.screen.width;
    double aspectRatio = globals.screen.aspectRatio;
    double textScale = globals.screen.textScale;

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
                    var armortisseurModel = ArmortisseurModel(
                            date: addOrEditLogic.date,
                            rear: addOrEditLogic.rear,
                            front: addOrEditLogic.front,
                            km: double.parse(
                                addOrEditLogic.controllers[0].text),
                            note: (addOrEditLogic.controllers[1].text))
                        .toJson();
                    addOrEditLogic.saveChanges(
                        key: Constants.amortisseurPref,
                        object: armortisseurModel,
                        context: context);
                  }
                })
          ],
          title: Text('Add Armortisseur item'),
        ),
        body: Form(
          key: addOrEditLogic.formKey,
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: ListView(
              children: <Widget>[
                DateChooser(
                  addOrEditLogic: addOrEditLogic,
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top:
                            globals.screen.convert(30, globals.screen.height))),
                for (int i = 0; i < 2; i++)
                  Center(
                    child: MyTextField(
                      textFieldType: globals.addOrEditPages[1]['textFields'][i]
                          ['type'],
                      textEditingController: addOrEditLogic.controllers[i],
                      label: globals.addOrEditPages[1]['textFields'][i]
                          ['label'],
                    ),
                  ),
                Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Front / Av',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Checkbox(
                            value: addOrEditLogic.yesOrNo[0],
                            onChanged: (x) {
                              addOrEditLogic.yesOrNo[0] = x;
                              addOrEditLogic.notifyListeners();
                            })
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Rear / Av',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Checkbox(
                            value: addOrEditLogic.yesOrNo[1],
                            onChanged: (x) {
                              addOrEditLogic.yesOrNo[1] = x;
                              addOrEditLogic.notifyListeners();
                            })
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
