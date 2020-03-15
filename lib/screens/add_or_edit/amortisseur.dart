import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/add_edit_args.dart';
import 'package:notes/models/amortisseur.dart';
import 'package:notes/utility/screen.dart';
import 'package:notes/widgets/date_chooser.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';

class Armortisseur extends StatelessWidget {
  static const String route = '/armortisseur';
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
      builder: (BuildContext context, AddOrEditLogic value, Widget child) =>
          SafeArea(
        child: Scaffold(
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
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 24 / aspectRatio * aspectRatio,
                  ),
                  onPressed: () {
                    addOrEditLogic.saveChanges(
                      key: SharedPrefKeys.amortisseurPref,
                      object: ArmortisseurModel(
                              date: addOrEditLogic.date,
                              rear: addOrEditLogic.yesOrNo[1],
                              front: addOrEditLogic.yesOrNo[0],
                              km: addOrEditLogic.controllers[0].text == ''
                                  ? null
                                  : num.parse(
                                      addOrEditLogic.controllers[0].text),
                              note: (addOrEditLogic.controllers[1].text))
                          .toJson(),
                      context: context,
                    );
                  })
            ],
          ),
          body: ScrollConfiguration(
            behavior: ScrollBehavior(),
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
                      textFieldType: globals.addOrEditPages[1]['textFields'][i]
                          ['type'],
                      textEditingController: addOrEditLogic.controllers[i],
                      label: globals.addOrEditPages[1]['textFields'][i]
                          ['label'],
                    ),
                  ),
                Padding(
                    padding: EdgeInsets.only(
                        top:
                            globals.screen.convert(30, globals.screen.height))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Front / AV',
                          style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: screen.convert(20, aspectRatio),
                              fontWeight: FontWeight.w700),
                        ),
                        Checkbox(
                            value: addOrEditLogic.yesOrNo[0],
                            onChanged: (x) {
                              addOrEditLogic.yesOrNo[0] = x;
                              addOrEditLogic.notifyListeners();
                            })
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Rear / AR',
                          style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: screen.convert(20, aspectRatio),
                              fontWeight: FontWeight.w700),
                        ),
                        Checkbox(
                            value: addOrEditLogic.yesOrNo[1],
                            onChanged: (x) {
                              addOrEditLogic.yesOrNo[1] = x;
                              addOrEditLogic.notifyListeners();
                            })
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
