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
  bool edit;
  int index;
  Vidangee({@required this.sharedPreferences, this.edit = false, this.index});
  @override
  _VidangeeState createState() => _VidangeeState();
}

class _VidangeeState extends State<Vidangee> {
  List<TextEditingController> controllers;
  List<bool> yesOrNo;
  Map<String, dynamic> decodedelement;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllers = List.generate(6, (_) => TextEditingController());
    yesOrNo = List.filled(6, false);

    if (widget.index != null) {
      decodedelement = jsonDecode(widget.sharedPreferences
          .getStringList(Constants.vidange)[widget.index]);
      print(decodedelement);
      date = decodedelement['date'];
      controllers[0].text = decodedelement['km'].toString();
      controllers[1].text = decodedelement['nextOil'].toString();
      controllers[2].text = decodedelement['oil']['price'] == null
          ? ''
          : decodedelement['oil']['price'].toString();
      controllers[3].text = decodedelement['air']['price'] == null
          ? ''
          : decodedelement['air']['price'].toString();
      controllers[4].text = decodedelement['fuel']['price'] == null
          ? ''
          : decodedelement['fuel']['price'].toString();
      controllers[5].text = decodedelement['clim']['price'] == null
          ? ''
          : decodedelement['clim']['price'].toString();
      yesOrNo[0] = decodedelement['oil']['yesOrNo'];
      yesOrNo[1] = decodedelement['air']['yesOrNo'];
      yesOrNo[2] = decodedelement['fuel']['yesOrNo'];
      yesOrNo[3] = decodedelement['clim']['yesOrNo'];
    }
  }

  var formKey = GlobalKey<FormState>();
  String date;
  Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    print(jsonDecode(widget.sharedPreferences
            .getStringList(Constants.vidange)[0])['oil']['price'] ==
        'null');
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.pop(context);
        }),
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
                    style: TextStyle(color: color),
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
                    child: Checkbox(
                        value: yesOrNo[0],
                        onChanged: (value) {
                          yesOrNo[0] = value;
                          setState(() {});
                        }),
                  ),
                  Flexible(
                      flex: 1,
                      child: MyTextField(
                        isRequired: false,
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
                    child: Checkbox(
                        value: yesOrNo[1],
                        onChanged: (value) {
                          yesOrNo[1] = value;
                          setState(() {});
                        }),
                  ),
                  Flexible(
                      flex: 1,
                      child: MyTextField(
                        isRequired: false,
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
                    child: Checkbox(
                        value: yesOrNo[2],
                        onChanged: (value) {
                          yesOrNo[2] = value;
                          setState(() {});
                        }),
                  ),
                  Flexible(
                      flex: 1,
                      child: MyTextField(
                        isRequired: false,
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
                    child: Checkbox(
                        value: yesOrNo[3],
                        onChanged: (value) {
                          yesOrNo[3] = value;
                          setState(() {});
                        }),
                  ),
                  Flexible(
                      flex: 1,
                      child: MyTextField(
                        isRequired: false,
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
                              price: controllers[2].text.isEmpty
                                  ? null
                                  : double.parse(controllers[2].text)),
                          air: VidangeFilterModel(
                            yesOrNo: yesOrNo[1],
                            price: controllers[3].text.isEmpty
                                ? null
                                : double.parse(controllers[3].text),
                          ),
                          fuel: VidangeFilterModel(
                              yesOrNo: yesOrNo[2],
                              price: controllers[4].text.isEmpty
                                  ? null
                                  : double.parse(controllers[4].text)),
                          clim: VidangeFilterModel(
                              yesOrNo: yesOrNo[3],
                              price: controllers[5].text.isEmpty
                                  ? null
                                  : double.parse(controllers[5].text)));

                      list.add(jsonEncode(courroieModel.toJson()));
                      widget.sharedPreferences
                          .setStringList(Constants.vidange, list)
                          .then((x) {
                        Navigator.pop(
                            context, jsonEncode(courroieModel.toJson()));
                      });
                    }
                    if (date == null) {
                      color = Colors.red;
                      setState(() {});
                    }
                    var list = widget.sharedPreferences
                        .getStringList(Constants.vidange);
                  },
                  child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
