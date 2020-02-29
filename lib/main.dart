import 'package:flutter/material.dart';
import 'package:notes/logic/main_view.dart';
import 'package:notes/logic/vidange.dart';
import 'package:notes/models/add_or_edit.dart';
import 'package:notes/models/date_view.dart';
import 'package:notes/screens/add_or_edit/amortisseur.dart';
import 'package:notes/screens/add_or_edit/batterie.dart';
import 'package:notes/screens/date_view/date_view.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logic/date_view.dart';
import 'logic/passed_parameters.dart';
import 'screens/add_or_edit/courroie.dart';
import 'screens/main_view/main_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}
//      providers: <SingleChildWidget>[
//        ChangeNotifierProvider(
//          create: (BuildContext context) => AmortisseurLogic(),
//        ),
//        ChangeNotifierProvider(
//          create: (BuildContext context) => BatterieLogic(),
//        ),
//        ChangeNotifierProvider(
//          create: (BuildContext context) => CourroieLogic(),
//        ),
//      ],

class _MyAppState extends State<MyApp> {
  SharedPreferences sharedPreferences;
  MaterialPageRoute materialPageRoute(Widget widget) =>
      MaterialPageRoute(builder: (_) => widget);
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<SharedPreferences>(
            create: (BuildContext context) => SharedPreferences.getInstance()),
        ChangeNotifierProvider(
            create: (BuildContext context) => GlobalVariables())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (routeSetting) {
            if (routeSetting.name == MainView.route) {
              return materialPageRoute(ChangeNotifierProvider(
                  create: (BuildContext context) =>
                      MainViewLogic(context: context),
                  child: MainView()));
            } else if (routeSetting.name == DateView.route) {
              final DateViewModelArg args = routeSetting.arguments;
              return materialPageRoute(ChangeNotifierProvider(
                create: (BuildContext context) => DateViewLogic(
                    context: context,
                    indexx: Provider.of<GlobalVariables>(context, listen: false)
                        .mainViewindex,
                    sharedPreferencesKey:
                        Provider.of<GlobalVariables>(context, listen: false)
                            .sharedPrefKey,
                    sharedPreferences:
                        Provider.of<SharedPreferences>(context, listen: false)),
                child: DateView(
                  index: args.index,
                  sharedPreferencesKey: args.sharedPreferencesKey,
                ),
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
                      sharedPreferences: Provider.of<SharedPreferences>(context,
                          listen: false)),
                  child: Vidangee(
                    index: addOrEditModelArgs?.index,
                  ),
                ));
              } else if (routeSetting.name == Courroie.route) {
                return materialPageRoute(Courroie(
                  index: addOrEditModelArgs?.index,
                ));
              } else if (routeSetting.name == Batterie.route) {
                return materialPageRoute(Batterie(
                  index: addOrEditModelArgs?.index,
                ));
              } else if (routeSetting.name == Armortisseur.route) {
                return materialPageRoute(Armortisseur(
                  index: addOrEditModelArgs?.index,
                ));
              } else {
                return null;
              }
            }
          }),
    );
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
