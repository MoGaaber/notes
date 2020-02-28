import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/models/amortisseur.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Armortisseur extends StatefulWidget {
  SharedPreferences sharedPreferences;
  Armortisseur({@required this.sharedPreferences});
  @override
  _ArmortisseurState createState() => _ArmortisseurState();
}

class _ArmortisseurState extends State<Armortisseur> {
  String date;
  List<TextEditingController> controllers;
  bool front = false;
  bool rear = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllers = List.generate(2, (_) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    print(widget.sharedPreferences.getStringList(Constants.amortisseurPref));
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
                Column(
                  children: <Widget>[
                    Text('Front/Av'),
                    Checkbox(
                        value: front,
                        onChanged: (front) {
                          this.front = front;
                          setState(() {});
                        })
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('Rear/Av'),
                    Checkbox(
                        value: rear,
                        onChanged: (rear) {
                          this.rear = rear;
                          setState(() {});
                        })
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Note',
                ),
                Flexible(
                    flex: 2,
                    child: MyTextField(
                      textInputType: TextInputType.text,
                      textEditingController: controllers[1],
                    )),
              ],
            ),
            FlatButton(
                onPressed: () {
                  var key = Constants.amortisseurPref;
                  var list = widget.sharedPreferences.getStringList(key);
                  ArmortisseurModel armortisseurModel = ArmortisseurModel(
                      date: date,
                      rear: rear,
                      front: front,
                      km: double.parse(controllers[0].text),
                      note: (controllers[1].text));
                  list.add(jsonEncode(armortisseurModel.toJson()));
                  widget.sharedPreferences
                      .setStringList(Constants.amortisseurPref, list);
                },
                child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
