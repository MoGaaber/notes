import 'package:flutter/material.dart';
import 'package:notes/logic/add_or_edit.dart';

class DateChooser extends StatelessWidget {
  AddOrEditLogic addOrEditLogic;
  DateChooser({this.addOrEditLogic});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        trailing: Material(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          type: MaterialType.canvas,
          color: Colors.orange,
          child: IconButton(
              iconSize: 30,
              icon: Icon(
                Icons.date_range,
                color: Colors.white,
              ),
              onPressed: () {
                addOrEditLogic.showDatePick(context);
              }),
        ),
        subtitle: Text(
          addOrEditLogic.date,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        title: Text(
          'Date',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
        ),
      ),
    );
/*
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Date',
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    addOrEditLogic.date,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Material(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                type: MaterialType.canvas,
                color: Colors.orange,
                child: IconButton(
                    iconSize: 30,
                    icon: Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      addOrEditLogic.showDatePick(context);
                    }),
              ),
            ],
          ),
        ],
      ),
    );
*/
  }
}
