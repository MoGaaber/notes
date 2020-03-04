import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/amortisseur.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/models/frienage.dart';
import 'package:notes/widgets/date_chooser.dart';
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
    Globals globals = Provider.of<Globals>(context, listen: false);

    double height = globals.screen.height;
    double width = globals.screen.width;
    double aspectRatio = globals.screen.aspectRatio;
    double textScale = globals.screen.textScale;
    print(addOrEditLogic.controllers.length);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.check,
                  size: 24 / aspectRatio * aspectRatio,
                ),
                onPressed: () {
                  if (addOrEditLogic.formKey.currentState.validate() &&
                      addOrEditLogic.date != null) {
                    addOrEditLogic.saveChanges(
                        key: SharedPrefKeys.frenagePref,
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
              padding: EdgeInsets.symmetric(
                  horizontal: globals.screen.convert(10, width)),
              children: <Widget>[
                DateChooser(
                  addOrEditLogic: addOrEditLogic,
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 2),
                      title: Text(
                        'DiscFrien',
                        style: Theme.of(context).textTheme.display2,
                      ),
                    ),
                    Center(
                      child: MyTextField(
                        textFieldType: TextFieldType.number,
                        label: 'KM',
                        textEditingController: addOrEditLogic.controllers[0],
                      ),
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
                    Divider(
                      height: 30,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 2),
                      title: Text(
                        'Plaqweta',
                        style: Theme.of(context).textTheme.display2,
                      ),
                    ),
                    Center(
                      child: MyTextField(
                        textFieldType: TextFieldType.number,
                        label: 'KM',
                        textEditingController: addOrEditLogic.controllers[1],
                      ),
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
                    Padding(
                        padding: EdgeInsets.only(
                            top: globals.screen.convert(30, height)))
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
