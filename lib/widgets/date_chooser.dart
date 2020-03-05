import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/logic/globals.dart';
import 'package:provider/provider.dart';

class DateChooser extends StatelessWidget {
  AddOrEditLogic addOrEditLogic;

  DateChooser({this.addOrEditLogic});

  @override
  Widget build(BuildContext context) {
    Globals globals = Provider.of<Globals>(context, listen: false);
    double height = globals.screen.height;
    double width = globals.screen.width;
    double aspectRatio = globals.screen.aspectRatio;
    double textScale = globals.screen.textScale;

    var screen = globals.screen;
    return Padding(
      padding: EdgeInsets.only(top: screen.convert(14, height)),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Date',
              style: TextStyle(
                  fontSize: screen.convert(50, screen.textScale),
                  fontWeight: FontWeight.w700),
            ),
          ),
          ListTile(
            contentPadding:
                EdgeInsets.only(left: screen.convert(8, screen.width)),
            trailing: SizedBox(
              width: screen.convert(80, width),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                type: MaterialType.canvas,
                color: Colors.orangeAccent,
                child: IconButton(
                    iconSize: screen.convert(35, screen.aspectRatio),
                    icon: Icon(
                      Icons.date_range,
                      color: Colors.white,
                      size: screen.convert(30, screen.aspectRatio),
                    ),
                    onPressed: () {
                      addOrEditLogic.showDatePick(context);
                    }),
              ),
            ),
            title: Text(
              addOrEditLogic.date,
              style: TextStyle(
                  fontSize:
                      globals.screen.convert(20, globals.screen.textScale),
                  fontWeight: FontWeight.w700),
            ),
          ),
          Divider(
            height: globals.screen.convert(30, height),
          ),
        ],
      ),
    );
  }
}
