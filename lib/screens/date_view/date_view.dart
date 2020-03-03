import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/date_view.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/screens/add_or_edit/amortisseur.dart';
import 'package:notes/screens/add_or_edit/batterie.dart';
import 'package:notes/screens/add_or_edit/courroie.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateView extends StatelessWidget {
  static const String route = '/dateView';
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    DateViewLogic dateViewLogic =
        Provider.of<DateViewLogic>(context, listen: true);
    Globals globals = Provider.of<Globals>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          actions: <Widget>[
/*
            RotationTransition(
              child:
                  IconButton(icon: Icon(Icons.arrow_upward), onPressed: () {}),
              turns: dateViewLogic.animation,
            )
*/
          ],
          title: Text(
            globals.addOrEditPages[globals.mainViewIndex]['name'],
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          elevation: 1,
          onPressed: () {
            dateViewLogic.navigateToSave(context: context, index: null);
          },
        ),
        body: dateViewLogic.list.length == 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Spacer(
                    flex: 3,
                  ),
                  Center(
                    child: Icon(
                      Icons.do_not_disturb,
                      size: 120,
                      color: Colors.orange,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Not item added yet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 6,
                  ),
                ],
              )
            : ListView.separated(
                padding: EdgeInsets.only(top: 1),
                itemCount: dateViewLogic.list.length,
                itemBuilder: (BuildContext context, int index) => Dismissible(
                  key: GlobalKey(debugLabel: index.toString()),
                  onDismissed: (x) {
                    dateViewLogic.deleteItem(index: index);
                  },
                  child: Stack(
                    children: <Widget>[
                      ListTile(
                        onTap: () {
//                          dateViewLogic.navigateToSave(
//                              context: context, index: index);
                        },
                        title: Text(
                          jsonDecode(dateViewLogic.list[index])['Date'],
                          style: GoogleFonts.cairo(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment(0.9, 0),
                          child: InkWell(
                            onTap: () {
                              dateViewLogic.deleteItem(index: index);
                            },
                            child: Material(
                              color: Colors.red,
                              type: MaterialType.circle,
                              child: Icon(
                                Icons.remove,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 20,
                ),
              ),
      ),
    );
  }
}
