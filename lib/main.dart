import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:notes/logic/details_view.dart';
import 'package:notes/logic/main_view.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/screens/add_or_edit/amortisseur.dart';
import 'package:notes/screens/add_or_edit/batterie.dart';
import 'package:notes/screens/add_or_edit/frenage.dart';
import 'package:notes/screens/date_view.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:notes/screens/details_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logic/date_view.dart';
import 'logic/globals.dart';
import 'screens/add_or_edit/courroie.dart';
import 'screens/main_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<SharedPreferences>(
            create: (BuildContext context) => SharedPreferences.getInstance()),
        Provider<Globals>(create: (BuildContext context) => Globals(context)),
        ChangeNotifierProvider<MainViewLogic>(
          create: (BuildContext context) => MainViewLogic(),
        ),
        ChangeNotifierProvider<DateViewLogic>(
          create: (BuildContext context) {
            return DateViewLogic(context);
          },
        ),
        ChangeNotifierProvider<DetailsViewLogic>(
          create: (BuildContext context) => DetailsViewLogic(),
        ),
        ChangeNotifierProvider<AddOrEditLogic>(
            create: (BuildContext context) => AddOrEditLogic(context)),
      ],
      child: MaterialApp(
        color: Colors.orange,
        title: 'Car Note',
        theme: ThemeData(
            textTheme: TextTheme(
              subhead: TextStyle(
                  fontSize: (25 / MediaQuery.textScaleFactorOf(context)) *
                      MediaQuery.textScaleFactorOf(context),
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
              display2: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white),
                actionsIconTheme: IconThemeData(
                  color: Colors.white,
                )),
            primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)),
            primaryColor: Colors.orange,
            iconTheme: IconThemeData(color: Colors.white),
            accentColor: Colors.orange,
            dialogTheme: DialogTheme(
                titleTextStyle: TextStyle(fontSize: 16, color: Colors.black),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                contentTextStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            primaryColorLight: Colors.white,
            primaryColorDark: Colors.white,
            accentColorBrightness: Brightness.light,
//            splashColor: Colors.transparent,
//            highlightColor: Colors.transparent,
            scaffoldBackgroundColor: Colors.white),
        initialRoute: MainView.route,
        routes: {
          DetailsView.route: (_) => DetailsView(),
          Batterie.route: (_) => Batterie(),
          Armortisseur.route: (_) => Armortisseur(),
          Courroie.route: (_) => Courroie(),
          Vidangee.route: (_) => Vidangee(),
          MainView.route: (_) => MainView(),
          DateView.route: (_) => DateView(),
          Freinage.route: (_) => Freinage()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

/*
      /*    onGenerateRoute: (routeSetting) {
          if (routeSetting.name == MainView.route) {
            return materialPageRoute(ChangeNotifierProvider(
                create: (BuildContext __) => MainViewLogic(context: __),
                child: MainView()));
          } else if (routeSetting.name == DateView.route) {
            final DateViewModelArg args = routeSetting.arguments;
            return materialPageRoute(ChangeNotifierProvider(
              create: (BuildContext context) => DateViewLogic(
                  context: context,
                  selectedMainViewElementIndex:
                      Provider.of<GlobalVariables>(context, listen: false)
                          .mainViewIndex,
                  sharedPreferences:
                      Provider.of<SharedPreferences>(context, listen: false)),
              child: DateView(),
            ));
          } else {
            AddOrEditModelArgs addOrEditModelArgs;
            if (routeSetting.arguments != null) {
              addOrEditModelArgs = routeSetting.arguments;
            }
            if (routeSetting.name == Vidangee.route) {
              return materialPageRoute(ChangeNotifierProvider(
                create: (BuildContext context) => VidangeLogic(
                    dateViewIndex:
                        Provider.of<GlobalVariables>(context, listen: false)
                            .dateViewIndex,
                    sharedPreferences:
                        Provider.of<SharedPreferences>(context, listen: false)),
                child: Vidangee(),
              ));
            } else if (routeSetting.name == Courroie.route) {
              return materialPageRoute(Courroie());
            } else if (routeSetting.name == Batterie.route) {
              return materialPageRoute(Batterie());
            } else if (routeSetting.name == Armortisseur.route) {
              return materialPageRoute(Armortisseur());
            } else {
              return null;
            }
          }
        }*/

//        ChangeNotifierProvider(
//          create: (BuildContext context) => AmortisseurLogic(),
//        ),
//        ChangeNotifierProvider(
//          create: (BuildContext context) => BatterieLogic(),
//        ),
//        ChangeNotifierProvider(
//          create: (BuildContext context) => CourroieLogic(),
//        ),

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
