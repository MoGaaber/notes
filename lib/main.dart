import 'package:flutter/material.dart';
import 'package:notes/logic/main_view.dart';
import 'package:notes/logic/add_or_edit.dart';
import 'package:notes/screens/add_or_edit/amortisseur.dart';
import 'package:notes/screens/add_or_edit/batterie.dart';
import 'package:notes/screens/add_or_edit/frenage.dart';
import 'package:notes/screens/date_view/date_view.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logic/date_view.dart';
import 'logic/globals.dart';
import 'screens/add_or_edit/courroie.dart';
import 'screens/main_view/main_view.dart';

void main() => runApp(MultiProvider(
      child: MyApp(),
      providers: [
        FutureProvider<SharedPreferences>(
            create: (BuildContext context) => SharedPreferences.getInstance()),
        ChangeNotifierProvider(create: (BuildContext context) => Globals()),
      ],
    ));

// This widget is the root of your application.

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialPageRoute materialPageRoute(Widget widget) =>
      MaterialPageRoute(builder: (_) => widget);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)),
          primaryColor: Colors.orange,
          iconTheme: IconThemeData(color: Colors.white),
          accentColor: Colors.orange,
          primaryColorLight: Colors.white,
          primaryColorDark: Colors.white,
          accentColorBrightness: Brightness.light,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white),
      initialRoute: MainView.route,
      routes: {
        Batterie.route: (_) => ChangeNotifierProvider(
            child: Batterie(),
            create: (BuildContext context) => AddOrEditLogic(
                addOrEditPages:
                    Provider.of<Globals>(context, listen: false).addOrEditPages,
                mainViewIndex:
                    Provider.of<Globals>(context, listen: false).mainViewIndex,
                dateViewIndex:
                    Provider.of<Globals>(context, listen: false).dateViewIndex,
                sharedPreferences:
                    Provider.of<SharedPreferences>(context, listen: false))),
        Armortisseur.route: (_) => ChangeNotifierProvider(
            child: Armortisseur(),
            create: (BuildContext context) => AddOrEditLogic(
                addOrEditPages:
                    Provider.of<Globals>(context, listen: false).addOrEditPages,
                mainViewIndex:
                    Provider.of<Globals>(context, listen: false).mainViewIndex,
                dateViewIndex:
                    Provider.of<Globals>(context, listen: false).dateViewIndex,
                sharedPreferences:
                    Provider.of<SharedPreferences>(context, listen: false))),
        Courroie.route: (_) => ChangeNotifierProvider(
            child: Courroie(),
            create: (BuildContext context) => AddOrEditLogic(
                addOrEditPages:
                    Provider.of<Globals>(context, listen: false).addOrEditPages,
                mainViewIndex:
                    Provider.of<Globals>(context, listen: false).mainViewIndex,
                dateViewIndex:
                    Provider.of<Globals>(context, listen: false).dateViewIndex,
                sharedPreferences:
                    Provider.of<SharedPreferences>(context, listen: false))),
        Vidangee.route: (_) => ChangeNotifierProvider(
            child: Vidangee(),
            create: (BuildContext context) => AddOrEditLogic(
                addOrEditPages:
                    Provider.of<Globals>(context, listen: false).addOrEditPages,
                mainViewIndex:
                    Provider.of<Globals>(context, listen: false).mainViewIndex,
                dateViewIndex:
                    Provider.of<Globals>(context, listen: false).dateViewIndex,
                sharedPreferences:
                    Provider.of<SharedPreferences>(context, listen: false))),
        MainView.route: (_) => ChangeNotifierProvider(
            create: (BuildContext context) => MainViewLogic(),
            child: MainView()),
        DateView.route: (_) => ChangeNotifierProvider.value(
            value: DateViewLogic(
                context: context,
                selectedMainViewElementIndex:
                    Provider.of<Globals>(context, listen: false).mainViewIndex,
                sharedPreferences:
                    Provider.of<SharedPreferences>(context, listen: false)),
            child: DateView()),
        Freinage.route: (_) => ChangeNotifierProvider(
            child: Freinage(),
            create: (BuildContext context) => AddOrEditLogic(
                addOrEditPages:
                    Provider.of<Globals>(context, listen: false).addOrEditPages,
                mainViewIndex:
                    Provider.of<Globals>(context, listen: false).mainViewIndex,
                dateViewIndex:
                    Provider.of<Globals>(context, listen: false).dateViewIndex,
                sharedPreferences:
                    Provider.of<SharedPreferences>(context, listen: false)))
      },
      debugShowCheckedModeBanner: false,
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
