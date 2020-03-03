import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/models/amortisseur.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/models/courroie.dart';
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
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
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Date',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  addOrEditLogic.date,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Material(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              type: MaterialType.canvas,
                              color: Colors.orange,
                              child: IconButton(
                                  iconSize: 30,
                                  icon: Icon(
                                    Icons.date_range,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    addOrEditLogic.showDatePick(context);
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox.fromSize(
                  size: Size.fromHeight(20),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: MyTextField(
                    label: 'KM',
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    textEditingController: addOrEditLogic.controllers[0],
                  ),
                ),
                SizedBox.fromSize(
                  size: Size.fromHeight(30),
                ),
                Center(
                  child: MyTextField(
                    textInputType: TextInputType.text,
                    label: 'Note',
                    textEditingController: addOrEditLogic.controllers[1],
                  ),
                ),
                SizedBox.fromSize(
                  size: Size.fromHeight(40),
                ),
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
