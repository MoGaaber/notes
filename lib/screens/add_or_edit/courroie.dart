import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';

class Courroie extends StatelessWidget {
  static const String route = '/courroie';

  String date;
  @override
  Widget build(BuildContext context) {
    AddOrEditLogic addOrEditLogic =
        Provider.of<AddOrEditLogic>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(iconTheme: IconThemeData(color: Colors.white), actions: <
            Widget>[
          IconButton(
            onPressed: () {
              if (addOrEditLogic.formKey.currentState.validate() &&
                  addOrEditLogic.date != null) {
                var object = CourroieModel(
                        date: addOrEditLogic.date,
                        km: double.parse(addOrEditLogic.controllers[0].text),
                        nextKm:
                            double.parse(addOrEditLogic.controllers[1].text),
                        note: (addOrEditLogic.controllers[2].text))
                    .toJson();

                addOrEditLogic.saveChanges(
                    context: context,
                    object: object,
                    key: Constants.courroiePref);
              }
            },
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
          )
        ]),
        body: Form(
          key: addOrEditLogic.formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
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
                  label: 'KM',
                  textEditingController: addOrEditLogic.controllers[0],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: MyTextField(
                  label: 'Next Km',
                  textEditingController: addOrEditLogic.controllers[1],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: MyTextField(
                  label: 'Note',
                  textEditingController: addOrEditLogic.controllers[2],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
