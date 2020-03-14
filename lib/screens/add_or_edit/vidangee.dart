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
    print(addOrEditLogic.decodedelement);
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
                  if (addOrEditLogic.formKey.currentState.validate() &&
                      addOrEditLogic.date != null) {
                    VidangeModel vidangeModel = VidangeModel(
                        note: addOrEditLogic.controllers[2].text,
                        date: addOrEditLogic.date,
                        km: addOrEditLogic.controllers[0].text == ''
                            ? null
                            : num.parse(addOrEditLogic.controllers[0].text),
                        nextOil: addOrEditLogic.controllers[1].text == ''
                            ? null
                            : num.parse(addOrEditLogic.controllers[1].text),
                        oil: VidangeFilterModel(
                            excited: addOrEditLogic.yesOrNo[0],
                            price: addOrEditLogic.controllers[3].text.isEmpty
                                ? null
                                : num.parse(
                                    addOrEditLogic.controllers[3].text)),
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
                                : num.parse(
                                    addOrEditLogic.controllers[5].text)),
                        clim: VidangeFilterModel(
                            excited: addOrEditLogic.yesOrNo[3],
                            price: addOrEditLogic.controllers[6].text.isEmpty
                                ? null
                                : num.parse(
                                    addOrEditLogic.controllers[6].text)));
                    print(vidangeModel.toJson());
                    addOrEditLogic.saveChanges(
                        context: context,
                        object: vidangeModel.toJson(),
                        key: SharedPrefKeys.vidangePref);
                  }
                })
          ],
        ),
        body: Form(
          key: addOrEditLogic.formKey,
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: ListView(
              padding: EdgeInsets.only(
                  bottom: globals.screen.convert(80, width),
                  top: globals.screen.convert(10, width)),
              children: <Widget>[
                DateChooser(
                  addOrEditLogic: addOrEditLogic,
                ),
                for (int i = 0;
                    i < globals.addOrEditPages[0]['textFields'].length;
                    i++)
                  Center(
                    child: MyTextField(
                      textFieldType: globals.addOrEditPages[0]['textFields'][i]
                          ['type'],
                      textEditingController: addOrEditLogic.controllers[i],
                      label: globals.addOrEditPages[0]['textFields'][i]
                          ['label'],
                    ),
                  ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Filtres ',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                for (int i = 3; i < 7; i++)
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Checkbox(
                            value: addOrEditLogic.yesOrNo[i - 3],
                            onChanged: (x) {
                              print(i);
                              print(addOrEditLogic.yesOrNo);
                              addOrEditLogic.yesOrNo[i - 3] = x;
                              addOrEditLogic.notifyListeners();
                            }),
                        Text(
                          list[i - 3],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    trailing: Padding(
                      padding: EdgeInsets.only(
                          bottom: globals.screen.convert(10, height)),
                      child: SizedBox.fromSize(
                        size: Size.fromWidth(globals.screen.convert(80, width)),
                        child: MyTextField(
                          textFieldType: TextFieldType.price,
                          textEditingController:
                              addOrEditLogic.controllers[i - 1],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
