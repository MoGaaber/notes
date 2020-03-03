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
  //controllers = List.generate(2, (_) => TextEditingController());
  static const String route = '/batterie';

  String date;
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
                    BatterieModel batteriModel = BatterieModel(
                        date: addOrEditLogic.date,
                        km: num.parse(addOrEditLogic.controllers[0].text),
                        note: (addOrEditLogic.controllers[1].text));
                    addOrEditLogic.saveChanges(
                        key: Constants.batteriPref,
                        object: batteriModel.toJson(),
                        context: context);
                  }
                })
          ],
          title: Text('Add Armortisseur item'),
        ),
        body: Form(
          key: addOrEditLogic.formKey,
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
                                    fontSize: 35, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                addOrEditLogic.date ??
                                    DateFormat.yMd().format(DateTime.now()),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Material(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
              SizedBox(
                height: 20,
              ),
              Center(
                child: MyTextField(
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  textEditingController: addOrEditLogic.controllers[0],
                  label: 'Km',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: MyTextField(
                  textInputType: TextInputType.text,
                  textEditingController: addOrEditLogic.controllers[1],
                  label: 'Note',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
