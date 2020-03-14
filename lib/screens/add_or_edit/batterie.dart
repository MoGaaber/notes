import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/add_edit_args.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/utility/screen.dart';
import 'package:notes/widgets/date_chooser.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';

class Batterie extends StatelessWidget {
  static const String route = '/batterie';
  String date;
  @override
  Widget build(BuildContext context) {
    AddOrEditLogic addOrEditLogic =
        Provider.of<AddOrEditLogic>(context, listen: false);
    Globals globals = Provider.of<Globals>(context, listen: false);

    double height = globals.screen.height;
    double width = globals.screen.width;
    double aspectRatio = globals.screen.aspectRatio;
    Screen screen = globals.screen;
    AddOrEditArgs addOrEditArgs = ModalRoute.of(context).settings.arguments;

    addOrEditLogic.initialize(addOrEditArgs.mainViewIndex,
        addOrEditArgs.dateViewIndex, addOrEditArgs.isAdd);

    return Consumer<AddOrEditLogic>(
      builder: (BuildContext context, value, Widget child) => SafeArea(
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
                    BatterieModel batteriModel = BatterieModel(
                        date: addOrEditLogic.date,
                        km: addOrEditLogic.controllers[0].text == ''
                            ? null
                            : num.parse(addOrEditLogic.controllers[0].text),
                        note: addOrEditLogic.controllers[1].text);
                    addOrEditLogic.saveChanges(
                        key: SharedPrefKeys.batteriPref,
                        object: batteriModel.toJson(),
                        context: context);
                  })
            ],
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/images/${globals.addOrEditPages[addOrEditLogic.mainViewIndex]['icon']}',
                  color: Colors.white,
                  width: screen.convert(50, width),
                  height: screen.convert(30, height),
                  fit: BoxFit.fitHeight,
                ),
                Text(
                    globals.addOrEditPages[addOrEditLogic.mainViewIndex]
                        ['name'],
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ],
            ),
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
                for (int i = 0; i < 2; i++)
                  Center(
                    child: MyTextField(
                      textFieldType: globals.addOrEditPages[3]['textFields'][i]
                          ['type'],
                      textEditingController: addOrEditLogic.controllers[i],
                      label: globals.addOrEditPages[3]['textFields'][i]
                          ['label'],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
