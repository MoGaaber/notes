import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/models/vidange.dart';
import 'package:notes/widgets/date_chooser.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Vidangee extends StatelessWidget {
  static const String route = '/vidangee';
// if doing something based on parameters
  List<String> list = ['Oil / Huile', 'Air', 'Carburant / Fuel', 'Clim'];
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
                color: Colors.white,
                size: 24 / aspectRatio * aspectRatio,
              ),
              onPressed: () {
                if (addOrEditLogic.formKey.currentState.validate() &&
                    addOrEditLogic.date != null) {
                  VidangeModel vidangeModel = VidangeModel(
                      note: addOrEditLogic.controllers[2].text,
                      date: addOrEditLogic.date,
                      km: num.parse(addOrEditLogic.controllers[0].text),
                      nextOil: num.parse(addOrEditLogic.controllers[1].text),
                      oil: VidangeFilterModel(
                          excited: addOrEditLogic.yesOrNo[0],
                          price: addOrEditLogic.controllers[3].text.isEmpty
                              ? null
                              : num.parse(addOrEditLogic.controllers[2].text)),
                      air: VidangeFilterModel(
                        excited: addOrEditLogic.yesOrNo[1],
                        price: addOrEditLogic.controllers[4].text.isEmpty
                            ? null
                            : num.parse(addOrEditLogic.controllers[3].text),
                      ),
                      fuel: VidangeFilterModel(
                          excited: addOrEditLogic.yesOrNo[2],
                          price: addOrEditLogic.controllers[5].text.isEmpty
                              ? null
                              : num.parse(addOrEditLogic.controllers[4].text)),
                      clim: VidangeFilterModel(
                          excited: addOrEditLogic.yesOrNo[3],
                          price: addOrEditLogic.controllers[6].text.isEmpty
                              ? null
                              : num.parse(addOrEditLogic.controllers[5].text)));
                  print(vidangeModel.toJson());
                  addOrEditLogic.saveChanges(
                      context: context,
                      object: vidangeModel.toJson(),
                      key: Constants.vidangePref);
                }
              })
        ],
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
            for (int i = 0;
                i < globals.addOrEditPages[0]['textFields'].length;
                i++)
              Center(
                child: MyTextField(
                  textFieldType: globals.addOrEditPages[0]['textFields'][i]
                      ['type'],
                  textEditingController: addOrEditLogic.controllers[i],
                  label: globals.addOrEditPages[0]['textFields'][i]['label'],
                ),
              ),
            Divider(
              indent: 30,
              endIndent: 30,
            ),
            ListTile(
              subtitle: Text(addOrEditLogic.date,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  )),
              title: Text(
                'Filtres ',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
              ),
            ),
            for (int i = 3; i < 7; i++)
              ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Checkbox(
                        value: addOrEditLogic.yesOrNo[i - 3],
                        onChanged: (x) {
                          addOrEditLogic.yesOrNo[i] = x;
                          addOrEditLogic.notifyListeners();
                        }),
                    Text(
                      list[i - 3],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                trailing: Padding(
                  padding: EdgeInsets.only(
                      bottom: globals.screen.convert(10, height)),
                  child: SizedBox.fromSize(
                    size: Size.fromWidth(globals.screen.convert(80, width)),
                    child: MyTextField(
                      textFieldType: TextFieldType.price,
                      textEditingController: addOrEditLogic.controllers[i],
                    ),
                  ),
                ),
              ),
            Padding(
                padding:
                    EdgeInsets.only(top: globals.screen.convert(10, height)))
          ],
        ),
      ),
    ));
  }
}
