import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/widgets/date_chooser.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';

class Courroie extends StatelessWidget {
  static const String route = '/courroie';

  String date;
  @override
  Widget build(BuildContext context) {
    AddOrEditLogic addOrEditLogic =
        Provider.of<AddOrEditLogic>(context, listen: true);
    Globals globals = Provider.of<Globals>(context, listen: false);

    double height = globals.screen.height;
    double width = globals.screen.width;
    double aspectRatio = globals.screen.aspectRatio;
    double textScale = globals.screen.textScale;

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
              size: 24 / aspectRatio * aspectRatio,
            ),
          )
        ]),
        body: Form(
          key: addOrEditLogic.formKey,
          child: ListView(
            children: <Widget>[
              DateChooser(
                addOrEditLogic: addOrEditLogic,
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom:
                          globals.screen.convert(20, globals.screen.height))),
              for (int i = 0; i < 3; i++)
                Center(
                  child: MyTextField(
                    textFieldType: globals.addOrEditPages[1]['textFields'][i]
                        ['type'],
                    textEditingController: addOrEditLogic.controllers[i],
                    label: globals.addOrEditPages[1]['textFields'][i]['label'],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
