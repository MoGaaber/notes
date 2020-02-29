import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/vidange.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/models/vidange.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Vidangee extends StatelessWidget {
  static const String route = '/vidangee';
  int index;
  Vidangee({this.index});
// if doing something based on parameters
  @override
  Widget build(BuildContext context) {
    VidangeLogic vidangeLogic =
        Provider.of<VidangeLogic>(context, listen: false);

    return Consumer<VidangeLogic>(
      builder:
          (BuildContext context, VidangeLogic vidangeLogic, Widget child) =>
              SafeArea(
        child: Scaffold(
          body: Form(
            key: vidangeLogic.formKey,
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
                      style: TextStyle(color: vidangeLogic.color),
                    ),
                    Text(
                      vidangeLogic.date == null ? '' : vidangeLogic.date,
                    ),
                    IconButton(
                        icon: Icon(Icons.date_range),
                        onPressed: () {
                          vidangeLogic.showDatePick(context);
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
                          textEditingController: vidangeLogic.controllers[0],
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Next oil change',
                    ),
                    Flexible(
                        flex: 2,
                        child: MyTextField(
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          textEditingController: vidangeLogic.controllers[1],
                        )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('hello'),
                    Spacer(
                      flex: 2,
                    ),
                    Flexible(
                      flex: 2,
                      child: Checkbox(
                          value: vidangeLogic.yesOrNo[0],
                          onChanged: (value) {
                            vidangeLogic.yesOrNo[0] = value;
                            vidangeLogic.notifyListeners();
                          }),
                    ),
                    Flexible(
                        flex: 1,
                        child: MyTextField(
                          isRequired: false,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          textEditingController: vidangeLogic.controllers[2],
                        )),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('hello'),
                    Spacer(
                      flex: 2,
                    ),
                    Flexible(
                      flex: 2,
                      child: Checkbox(
                          value: vidangeLogic.yesOrNo[1],
                          onChanged: (value) {
                            vidangeLogic.yesOrNo[1] = value;
                            vidangeLogic.notifyListeners();
                          }),
                    ),
                    Flexible(
                        flex: 1,
                        child: MyTextField(
                          isRequired: false,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          textEditingController: vidangeLogic.controllers[3],
                        )),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('hello'),
                    Spacer(
                      flex: 2,
                    ),
                    Flexible(
                      flex: 2,
                      child: Checkbox(
                          value: vidangeLogic.yesOrNo[2],
                          onChanged: (value) {
                            vidangeLogic.yesOrNo[2] = value;
                            vidangeLogic.notifyListeners();
                          }),
                    ),
                    Flexible(
                        flex: 1,
                        child: MyTextField(
                          isRequired: false,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          textEditingController: vidangeLogic.controllers[4],
                        )),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('hello'),
                    Spacer(
                      flex: 2,
                    ),
                    Flexible(
                      flex: 2,
                      child: Checkbox(
                          value: vidangeLogic.yesOrNo[3],
                          onChanged: (value) {
                            vidangeLogic.yesOrNo[3] = value;
                            vidangeLogic.notifyListeners();
                          }),
                    ),
                    Flexible(
                        flex: 1,
                        child: MyTextField(
                          isRequired: false,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          textEditingController: vidangeLogic.controllers[5],
                        )),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
                FlatButton(
                    onPressed: () {
                      vidangeLogic.addVidange(context);
                    },
                    child: Text('Save')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
