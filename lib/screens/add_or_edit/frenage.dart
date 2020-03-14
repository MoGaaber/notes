import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/add_edit_args.dart';
import 'package:notes/models/frienage.dart';
import 'package:notes/utility/screen.dart';
import 'package:notes/widgets/date_chooser.dart';
import 'package:notes/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:notes/logic/add_or_edit.dart';

class Freinage extends StatelessWidget {
  static const String route = '/freinage';
  @override
  Widget build(BuildContext context) {
    AddOrEditLogic addOrEditLogic =
        Provider.of<AddOrEditLogic>(context, listen: false);
    Globals globals = Provider.of<Globals>(context, listen: false);
    AddOrEditArgs addOrEditArgs = ModalRoute.of(context).settings.arguments;

    addOrEditLogic.initialize(addOrEditArgs.mainViewIndex,
        addOrEditArgs.dateViewIndex, addOrEditArgs.isAdd);

    double height = globals.screen.height;
    double width = globals.screen.width;
    double aspectRatio = globals.screen.aspectRatio;
    Screen screen = globals.screen;

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
                    size: 24 / aspectRatio * aspectRatio,
                  ),
                  onPressed: () {
                    addOrEditLogic.saveChanges(
                        key: SharedPrefKeys.freinagePref,
                        object: FrienageModel(
                                date: addOrEditLogic.date,
                                firstInnerModel: InnerModel(
                                  km: addOrEditLogic.controllers[0].text == ''
                                      ? null
                                      : num.parse(
                                          addOrEditLogic.controllers[0].text),
                                  front: addOrEditLogic.yesOrNo[0],
                                  rear: addOrEditLogic.yesOrNo[1],
                                ),
                                secondInnerModel: InnerModel(
                                    km: addOrEditLogic.controllers[1].text == ''
                                        ? null
                                        : num.parse(
                                            addOrEditLogic.controllers[1].text),
                                    front: addOrEditLogic.yesOrNo[2],
                                    rear: addOrEditLogic.yesOrNo[3]))
                            .toJson(),
                        context: context);
                  })
            ],
          ),
          body: Form(
            key: addOrEditLogic.formKey,
            child: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: globals.screen.convert(10, width)),
                children: <Widget>[
                  DateChooser(
                    addOrEditLogic: addOrEditLogic,
                  ),
                  Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 2),
                        title: Text(
                          'Disque de frein /Brake Disc',
                          style: Theme.of(context).textTheme.display2,
                        ),
                      ),
                      Center(
                        child: MyTextField(
                          textFieldType: TextFieldType.number,
                          label: 'KM',
                          textEditingController: addOrEditLogic.controllers[0],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Front / AV',
                                style: TextStyle(
                                    fontSize: screen.convert(18, aspectRatio),
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
                          Row(
                            children: <Widget>[
                              Text(
                                'Rear / AR',
                                style: TextStyle(
                                    fontSize: screen.convert(18, aspectRatio),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      Divider(
                        height: screen.convert(30, height),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: screen.convert(2, screen.width),
                        ),
                        title: Text(
                          'Plaquette de frien /Brake Pad',
                          style: Theme.of(context).textTheme.display2,
                        ),
                      ),
                      Center(
                        child: MyTextField(
                          textFieldType: TextFieldType.number,
                          label: 'KM',
                          textEditingController: addOrEditLogic.controllers[1],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Front / AV',
                                style: TextStyle(
                                    fontSize: screen.convert(18, aspectRatio),
                                    fontWeight: FontWeight.w700),
                              ),
                              Checkbox(
                                  value: addOrEditLogic.yesOrNo[2],
                                  onChanged: (x) {
                                    addOrEditLogic.yesOrNo[2] = x;
                                    addOrEditLogic.notifyListeners();
                                  })
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Rear / AR',
                                style: TextStyle(
                                    fontSize: screen.convert(18, aspectRatio),
                                    fontWeight: FontWeight.w700),
                              ),
                              Checkbox(
                                  value: addOrEditLogic.yesOrNo[3],
                                  onChanged: (x) {
                                    addOrEditLogic.yesOrNo[3] = x;
                                    addOrEditLogic.notifyListeners();
                                  })
                            ],
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: globals.screen.convert(80, height)))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
