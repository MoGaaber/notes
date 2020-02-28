import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Batterie extends StatefulWidget {
  SharedPreferences sharedPreferences;
  Batterie({@required this.sharedPreferences});
  @override
  _BatterieState createState() => _BatterieState();
}

class _BatterieState extends State<Batterie> {
  List<TextEditingController> controllers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllers = List.generate(2, (_) => TextEditingController());
  }

  String date;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
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
                  'Next KM',
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
            FlatButton(
                onPressed: () {
                  var key = Constants.batteriPref;
                  var list = widget.sharedPreferences.getStringList(key);
                  BatterieModel batteriModel = BatterieModel(
                      date: date,
                      km: double.parse(controllers[0].text),
                      note: (controllers[1].text));
                  list.add(jsonEncode(batteriModel.toJson()));
                  widget.sharedPreferences
                      .setStringList(Constants.batteriPref, list);
                },
                child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
