import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/add_edit_args.dart';
import 'package:notes/models/vidange.dart';
import 'package:notes/widgets/date_chooser.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';

class Vidangee extends StatelessWidget {
  static const String route = '/vidangee';
  List<String> list = ['Oil / Huile', 'Air', 'Carburant / Fuel', 'Clim'];
  @override
  Widget build(BuildContext context) {
    AddOrEditLogic addOrEditLogic =
        Provider.of<AddOrEditLogic>(context, listen: false);
    Globals globals = Provider.of<Globals>(context, listen: false);
    var screen = globals.screen;
    double height = globals.screen.height;
    double width = globals.screen.width;
    double aspectRatio = globals.screen.aspectRatio;
    AddOrEditArgs addOrEditArgs = ModalRoute.of(context).settings.arguments;

    addOrEditLogic.initialize(addOrEditArgs.mainViewIndex,
        addOrEditArgs.dateViewIndex, addOrEditArgs.isAdd);

    return Consumer<AddOrEditLogic>(
      builder: (BuildContext context, value, Widget child) => SafeArea(
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
              Text(globals.addOrEditPages[addOrEditLogic.mainViewIndex]['name'],
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ],
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 24 / aspectRatio * aspectRatio,
                ),
                onPressed: () {
                  VidangeModel vidangeModel = VidangeModel(
                      date: addOrEditLogic.date,
                      km: addOrEditLogic.controllers[0].text == ''
                          ? null
                          : num.parse(addOrEditLogic.controllers[0].text),
                      nextOil: addOrEditLogic.controllers[1].text == ''
                          ? null
                          : num.parse(addOrEditLogic.controllers[1].text),
                      note: addOrEditLogic.controllers[2].text,
                      oil: VidangeFilterModel(
                          excited: addOrEditLogic.yesOrNo[0],
                          price: addOrEditLogic.controllers[3].text.isEmpty
                              ? null
                              : num.parse(addOrEditLogic.controllers[3].text)),
                      air: VidangeFilterModel(
                        excited: addOrEditLogic.yesOrNo[1],
                        price: addOrEditLogic.controllers[4].text.isEmpty
                            ? null
                            : num.parse(addOrEditLogic.controllers[4].text),
                      ),
                      fuel: VidangeFilterModel(
                          excited: addOrEditLogic.yesOrNo[2],
                          price: addOrEditLogic.controllers[5].text.isEmpty
                              ? null
                              : num.parse(addOrEditLogic.controllers[5].text)),
                      clim: VidangeFilterModel(
                          excited: addOrEditLogic.yesOrNo[3],
                          price: addOrEditLogic.controllers[6].text.isEmpty
                              ? null
                              : num.parse(addOrEditLogic.controllers[6].text)));
                  addOrEditLogic.saveChanges(
                      context: context,
                      object: vidangeModel.toJson(),
                      key: SharedPrefKeys.vidangePref);
                })
          ],
        ),
        body: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: ListView(
            padding: EdgeInsets.only(
                bottom: globals.screen.convert(80, width),
                top: globals.screen.convert(10, width)),
            children: <Widget>[
              DateChooser(
                addOrEditLogic: addOrEditLogic,
              ),
              for (int i = 0; i < 3; i++)
                Center(
                  child: MyTextField(
                    textFieldType: globals.addOrEditPages[0]['textFields'][i]
                        ['type'],
                    textEditingController: addOrEditLogic.controllers[i],
                    label: globals.addOrEditPages[0]['textFields'][i]['label'],
                  ),
                ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screen.convert(8, height),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Filtres',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: screen.convert(30, aspectRatio),
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                      horizontal: screen.convert(8, width),
                    )),
                    Text(
                      'Prices',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: screen.convert(30, aspectRatio),
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              for (int i = 3; i < 7; i++)
                ListTile(
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Checkbox(
                          value: addOrEditLogic.yesOrNo[i - 3],
                          onChanged: (x) {
                            addOrEditLogic.yesOrNo[i - 3] = x;
                            addOrEditLogic.notifyListeners();
                          }),
                      Text(
                        list[i - 3],
                        style: TextStyle(
                            fontSize: screen.convert(20, aspectRatio),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  trailing: SizedBox.fromSize(
                    size: Size.fromWidth(globals.screen.convert(110, width)),
                    child: MyTextField(
                      textFieldType: TextFieldType.price,
                      textEditingController: addOrEditLogic.controllers[i],
                    ),
                  ),
                ),
            ],
          ),
        ),
      )),
    );
  }
}
