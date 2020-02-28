import 'package:flutter/material.dart';
import 'package:notes/screens/add_or_edit/amortisseur.dart';
import 'package:notes/screens/add_or_edit/batterie.dart';
import 'package:notes/screens/date_view/date_view.dart';
import 'package:notes/screens/details_view/courroie.dart';
import 'package:notes/screens/details_view/vidange.dart';
import 'package:notes/screens/vidange.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/constants.dart';
import 'models/batterie.dart';
import 'screens/add_or_edit/courroie.dart';
import 'screens/details_view/amortisseur.dart';
import 'screens/details_view/batterie.dart';
import 'screens/main_view/main_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Noticer',
        theme: ThemeData(),
        home: SafeArea(
          child: Scaffold(
            body: MainView(),
          ),
        ));
  }
}

/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List homeList = [
    'VIDANGE',
    'COURROIE',
    'AMORTISSEUR',
    'FRIENAGE',
    'BATTERIE'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        buildListTile(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Vidange();
          }));
        }, 'VIDANGE'),
        buildListTile(() {}, 'COURROIE'),
        buildListTile(() {}, 'AMORTISSEUR'),
        buildListTile(() {}, 'FRIENAGE'),
        buildListTile(() {}, 'BATTERIE'),
      ])),
    );
  }

  ListTile buildListTile(
    navigator,
    title,
  ) {
    return ListTile(
      onTap: () {
        navigator();
      },
      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.red, size: 30.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.red))),
        child: Icon(Icons.autorenew, color: Colors.pink),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
      ),
    );
  }
}
*/
