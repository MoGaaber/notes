import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Courroie extends StatefulWidget {
  static const String route = '/courroie';

  @override
  _CourroieState createState() => _CourroieState();
}

class _CourroieState extends State<Courroie> {
  List<TextEditingController> controllers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllers = List.generate(3, (_) => TextEditingController());
  }

  String date;
  @override
  Widget build(BuildContext context) {
    SharedPreferences sharedPreferences =
        Provider.of<SharedPreferences>(context, listen: false);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Note',
                ),
                Flexible(
                    flex: 2,
                    child: MyTextField(
                      textEditingController: controllers[2],
                      textInputType: TextInputType.text,
                    )),
              ],
            ),
            FlatButton(
                onPressed: () {
                  print('hello');
                  var key = Constants.courroiePref;
                  var list = sharedPreferences.getStringList(key);
                  CourroieModel courroieModel = CourroieModel(
                      date: date,
                      km: double.parse(controllers[0].text),
                      nextKm: double.parse(controllers[1].text),
                      note: (controllers[2].text));
                  list.add(jsonEncode(courroieModel.toJson()));
                  sharedPreferences.setStringList(Constants.courroiePref, list);
                },
                child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
