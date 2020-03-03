import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/models/vidange.dart';
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
                  VidangeModel vidangeModel = VidangeModel(
                      note: addOrEditLogic.controllers[2].text,
                      date: addOrEditLogic.date,
                      km: num.parse(addOrEditLogic.controllers[0].text),
                      nextOil: num.parse(addOrEditLogic.controllers[1].text),
                      oil: VidangeFilterModel(
                              excited: addOrEditLogic.yesOrNo[0],
                              price: addOrEditLogic.controllers[3].text.isEmpty
                                  ? null
                                  : num.parse(
                                      addOrEditLogic.controllers[2].text))
                          .toJson(),
                      air: VidangeFilterModel(
                        excited: addOrEditLogic.yesOrNo[1],
                        price: addOrEditLogic.controllers[4].text.isEmpty
                            ? null
                            : num.parse(addOrEditLogic.controllers[3].text),
                      ).toJson(),
                      fuel: VidangeFilterModel(
                              excited: addOrEditLogic.yesOrNo[2],
                              price: addOrEditLogic.controllers[5].text.isEmpty
                                  ? null
                                  : num.parse(
                                      addOrEditLogic.controllers[4].text))
                          .toJson(),
                      clim: VidangeFilterModel(
                              excited: addOrEditLogic.yesOrNo[3],
                              price: addOrEditLogic.controllers[6].text.isEmpty
                                  ? null
                                  : num.parse(
                                      addOrEditLogic.controllers[5].text))
                          .toJson());
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
          children: <Widget>[
            SizedBox(
              height: 10,
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
                              addOrEditLogic.date,
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
                label: 'KM/Miles',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: MyTextField(
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                textEditingController: addOrEditLogic.controllers[1],
                label: 'Next Oil Change',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: MyTextField(
                textInputType: TextInputType.text,
                textEditingController: addOrEditLogic.controllers[2],
                label: 'Note',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              indent: 30,
              endIndent: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                'Filtres ',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
              ),
            ),
            for (int i = 0; i < 4; i++)
              ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Checkbox(
                        value: addOrEditLogic.yesOrNo[i],
                        onChanged: (x) {
                          addOrEditLogic.yesOrNo[i] = x;
                          addOrEditLogic.notifyListeners();
                        }),
                    Text(
                      list[i],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SizedBox.fromSize(
                    size: Size.fromWidth(80),
                    child: TextField(
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: addOrEditLogic.controllers[i + 3],
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange))),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }
}
