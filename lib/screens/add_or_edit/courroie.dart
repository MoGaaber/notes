import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/add_edit_args.dart';
import 'package:notes/models/courroie.dart';
import 'package:notes/utility/screen.dart';
import 'package:notes/widgets/date_chooser.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';

class Courroie extends StatelessWidget {
  static const String route = '/courroie';
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
          backgroundColor: Colors.white,
          appBar: AppBar(
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
              iconTheme: IconThemeData(color: Colors.white),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    print(addOrEditLogic.controllers[2].text);
                    var object = CourroieModel(
                            date: addOrEditLogic.date,
                            km: addOrEditLogic.controllers[0].text == ''
                                ? null
                                : num.parse(addOrEditLogic.controllers[0].text),
                            nextKm: addOrEditLogic.controllers[1].text == ''
                                ? null
                                : num.parse(addOrEditLogic.controllers[1].text),
                            note: addOrEditLogic.controllers[2].text)
                        .toJson();

                    addOrEditLogic.saveChanges(
                        context: context,
                        object: object,
                        key: SharedPrefKeys.courroiePref);
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 24 / aspectRatio * aspectRatio,
                  ),
                )
              ]),
          body: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: globals.screen.convert(10, width)),
              children: <Widget>[
                DateChooser(
                  addOrEditLogic: addOrEditLogic,
                ),
                for (int i = 0; i < 3; i++)
                  Center(
                    child: MyTextField(
                      textFieldType: globals.addOrEditPages[1]['textFields'][i]
                          ['type'],
                      textEditingController: addOrEditLogic.controllers[i],
                      label: globals.addOrEditPages[1]['textFields'][i]
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
