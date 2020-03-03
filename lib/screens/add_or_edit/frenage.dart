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
  static const String route = '/freinage';
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
                    addOrEditLogic.saveChanges(
                        key: Constants.frenagePref,
                        object: FrienageModel(
                                date: addOrEditLogic.date,
                                firstInnerModel: InnerModel(
                                  km: num.parse(
                                      addOrEditLogic.controllers[0].text),
                                  front: addOrEditLogic.yesOrNo[0],
                                  rear: addOrEditLogic.yesOrNo[1],
                                ),
                                secondInnerModel: InnerModel(
                                    km: num.parse(
                                        addOrEditLogic.controllers[1].text),
                                    front: addOrEditLogic.yesOrNo[2],
                                    rear: addOrEditLogic.yesOrNo[3]))
                            .toJson(),
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
                  height: 10,
                ),
/*
                ListTile(
                  title: Text(
                    addOrEditLogic.date ??
                        DateFormat.yMd().format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
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
                        onPressed: () {
                          addOrEditLogic.showDatePick(context);
                        }),
                  ),
                ),
*/
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
                Divider(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox.fromSize(
                        size: Size.fromHeight(30),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'DiscFrien',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: Size.fromHeight(20),
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
                              Checkbox(
                                  value: addOrEditLogic.yesOrNo[0],
                                  onChanged: (x) {
                                    addOrEditLogic.yesOrNo[0] = x;
                                    addOrEditLogic.notifyListeners();
                                  })
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Rear / AV',
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      SizedBox.fromSize(
                        size: Size.fromHeight(30),
                      ),
                    ],
                  ),
                ),
                Divider(
                    //height: 30,
                    ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox.fromSize(
                        size: Size.fromHeight(30),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Plaqweta',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w700),
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
                          textEditingController: addOrEditLogic.controllers[1],
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
                              Checkbox(
                                  value: addOrEditLogic.yesOrNo[2],
                                  onChanged: (x) {
                                    addOrEditLogic.yesOrNo[2] = x;
                                    addOrEditLogic.notifyListeners();
                                  })
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Rear / AV',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              Checkbox(
                                  value: addOrEditLogic.yesOrNo[3],
                                  onChanged: (x) {
                                    addOrEditLogic.yesOrNo[3] = x;
                                    addOrEditLogic.notifyListeners();
                                  })
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
