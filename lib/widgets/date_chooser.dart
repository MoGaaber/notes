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
      padding: EdgeInsets.only(top: screen.convert(15, height)),
      child: ListTile(
        trailing: Material(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          type: MaterialType.canvas,
          color: Colors.orange,
          child: IconButton(
              iconSize: screen.convert(30, screen.aspectRatio),
              icon: Icon(
                Icons.date_range,
                color: Colors.white,
                size: screen.convert(25, screen.aspectRatio),
              ),
              onPressed: () {
                addOrEditLogic.showDatePick(context);
              }),
        ),
        subtitle: Text(
          addOrEditLogic.date,
          style: TextStyle(
            fontSize: screen.convert(15, screen.textScale),
            fontWeight: FontWeight.w400,
          ),
        ),
        title: Text(
          'Date',
          style: TextStyle(
              fontSize: screen.convert(35, screen.textScale),
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
