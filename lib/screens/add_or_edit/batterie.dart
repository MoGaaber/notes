import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Batterie extends StatelessWidget {
  List<TextEditingController> controllers;
  //controllers = List.generate(2, (_) => TextEditingController());
  static const String route = '/batterie';

  String date;
  @override
  Widget build(BuildContext context) {
    AddOrEditLogic addOrEditLogic =
        Provider.of<AddOrEditLogic>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: addOrEditLogic.formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Date',
                  ),
                  Text(
                    addOrEditLogic.date == null ? '' : addOrEditLogic.date,
                  ),
                  IconButton(
                      icon: Icon(Icons.date_range),
                      onPressed: () {
                        addOrEditLogic.showDatePick(context);
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'KM',
                  ),
                  Flexible(
                      flex: 2,
                      child: MyTextField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        textEditingController: addOrEditLogic.controllers[0],
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Note',
                  ),
                  Flexible(
                      flex: 2,
                      child: MyTextField(
                        textInputType: TextInputType.text,
                        textEditingController: addOrEditLogic.controllers[1],
                      )),
                ],
              ),
              FlatButton(
                  onPressed: () {
                    var batteriModel = BatterieModel(
                            date: addOrEditLogic.date,
                            km: double.parse(
                                addOrEditLogic.controllers[0].text),
                            note: (addOrEditLogic.controllers[1].text))
                        .toJson();
                    addOrEditLogic.saveChanges(
                        context: context,
                        object: batteriModel,
                        key: Constants.batteriPref);
                  },
                  child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
