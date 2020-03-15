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

    var screen = globals.screen;
    return Padding(
      padding: EdgeInsets.only(top: screen.convert(30, height)),
      child: Column(
        children: <Widget>[
          ListTile(
            trailing: SizedBox(
                width: screen.convert(120, width),
                height: screen.convert(80, height),
                child: FlatButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  onPressed: () {
                    addOrEditLogic.showDatePick(context);
                  },
                  child: Text(
                    'Change',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: screen.convert(18, screen.aspectRatio)),
                  ),
                )),
            title: Row(
              children: <Widget>[
                Text(
                  addOrEditLogic.date,
                  style: TextStyle(
                      fontSize:
                          globals.screen.convert(25, globals.screen.textScale),
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          Divider(
            height: 30,
          )
/*
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Date',
                style: TextStyle(
                    fontSize: screen.convert(50, screen.textScale),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                  width: screen.convert(50, width),
                  height: screen.convert(50, width),
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
                  )),
            ],
          ),
          Center(
            child: Text(
              addOrEditLogic.date,
              style: TextStyle(
                  fontSize:
                      globals.screen.convert(22, globals.screen.textScale),
                  fontWeight: FontWeight.w700,
                  color: Colors.orange),
            ),
          ),
          Divider(
            height: globals.screen.convert(30, height),
          ),
*/
        ],
      ),
    );
  }
}
/*
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

 */
