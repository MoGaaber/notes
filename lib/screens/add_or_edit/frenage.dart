import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/models/amortisseur.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/models/frienage.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class Freinage extends StatelessWidget {
  static const String route = '/armortisseur';
//  controllers = List.generate(2, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    AddOrEditLogic addOrEditLogic =
        Provider.of<AddOrEditLogic>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var armortisseurModel = ArmortisseurModel(
                    date: addOrEditLogic.date,
                    rear: addOrEditLogic.rear,
                    front: addOrEditLogic.front,
                    km: double.parse(addOrEditLogic.controllers[0].text),
                    note: (addOrEditLogic.controllers[1].text))
                .toJson();
            addOrEditLogic.saveChanges(
                key: Constants.amortisseurPref,
                object: armortisseurModel,
                context: context);
          },
          child: Icon(Icons.check),
        ),
        appBar: AppBar(
          title: Text('Add Armortisseur item'),
        ),
        body: Form(
          key: addOrEditLogic.formKey,
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                ListTile(
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      '01 / 03 / 2020',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  ),
                  title: Text(
                    'Choose Date',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  trailing: Material(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    type: MaterialType.canvas,
                    color: Colors.orange,
                    child: IconButton(
                        iconSize: 30,
                        icon: Icon(
                          Icons.date_range,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                  ),
                ),
                Divider(
                  height: 30,
                  indent: 30,
                  endIndent: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 1,
                            color: Colors.orange.withOpacity(0.8)),
                      ]),
                  child: Column(
                    children: <Widget>[
                      SizedBox.fromSize(
                        size: Size.fromHeight(30),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'DiscFrien',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: Size.fromHeight(30),
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
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Front / AV',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              Checkbox(value: false, onChanged: (_) {})
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Rear / AV',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              Checkbox(value: false, onChanged: (_) {})
                            ],
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      SizedBox.fromSize(
                        size: Size.fromHeight(30),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 1,
                            color: Colors.orange.withOpacity(0.8)),
                      ]),
                  child: Column(
                    children: <Widget>[
                      SizedBox.fromSize(
                        size: Size.fromHeight(30),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Plaqweta',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: Size.fromHeight(30),
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
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Front / AV',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              Checkbox(value: false, onChanged: (_) {})
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Rear / AV',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              Checkbox(value: false, onChanged: (_) {})
                            ],
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      SizedBox.fromSize(
                        size: Size.fromHeight(40),
                      ),
                    ],
                  ),
                ),
                SizedBox.fromSize(
                  size: Size.fromHeight(30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
