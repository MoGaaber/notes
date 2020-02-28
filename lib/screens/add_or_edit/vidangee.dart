import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/models/vidange.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Vidangee extends StatefulWidget {
  SharedPreferences sharedPreferences;
  Vidangee({@required this.sharedPreferences});
  @override
  _VidangeeState createState() => _VidangeeState();
}

class _VidangeeState extends State<Vidangee> {
  List<TextEditingController> controllers;
  List<bool> yesOrNo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllers = List.generate(6, (_) => TextEditingController());
    for (var i = 0; i < controllers.length; i++) {
//      controllers[i].text = '';
    }
    yesOrNo = List.filled(6, false);
  }

  var formKey = GlobalKey<FormState>();
  String date;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
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
                    date == null ? '' : date,
                  ),
                  IconButton(
                      icon: Icon(Icons.date_range),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1500, 1, 1),
                                lastDate: DateTime(2500, 1, 1))
                            .then((dateTime) {
                          this.date = DateFormat.yMd().format(dateTime);

                          setState(() {});
                        });
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
                        textEditingController: controllers[0],
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
                        textEditingController: controllers[1],
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
                    child: Row(
                      children: <Widget>[
                        Checkbox(value: false, onChanged: (value) {}),
                        Checkbox(value: false, onChanged: (value) {})
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: MyTextField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        textEditingController: this.controllers[2],
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
                    child: Row(
                      children: <Widget>[
                        Checkbox(value: false, onChanged: (value) {}),
                        Checkbox(value: false, onChanged: (value) {})
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: MyTextField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        textEditingController: this.controllers[3],
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
                    child: Row(
                      children: <Widget>[
                        Checkbox(value: false, onChanged: (value) {}),
                        Checkbox(value: false, onChanged: (value) {})
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: MyTextField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        textEditingController: this.controllers[4],
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
                    child: Row(
                      children: <Widget>[
                        Checkbox(value: false, onChanged: (value) {}),
                        Checkbox(value: false, onChanged: (value) {})
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: MyTextField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        textEditingController: this.controllers[5],
                      )),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
              FlatButton(
                  onPressed: () {
                    bool validate = formKey.currentState.validate();
                    if (validate && date != null) {
                      print('!');
                      var key = Constants.vidange;
                      var list = widget.sharedPreferences.getStringList(key);
                      VidangeModel courroieModel = VidangeModel(
                          date: date,
                          km: double.parse(controllers[0].text),
                          nextOil: double.parse(controllers[1].text),
                          oil: VidangeFilterModel(
                              yesOrNo: yesOrNo[0],
                              price: double.parse(controllers[2].text)),
                          air: VidangeFilterModel(
                            yesOrNo: yesOrNo[1],
                            price: double.parse(controllers[3].text),
                          ),
                          fuel: VidangeFilterModel(
                              yesOrNo: yesOrNo[2],
                              price: double.parse(controllers[4].text)),
                          clim: VidangeFilterModel(
                              yesOrNo: yesOrNo[3],
                              price: double.parse(controllers[5].text)));

                      list.add(jsonEncode(courroieModel.toJson()));
                      widget.sharedPreferences
                          .setStringList(Constants.vidange, list);
                    }
                  },
                  child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
