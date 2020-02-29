import 'package:flutter/material.dart';
import 'package:notes/logic/amortisseur.dart';
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

void main() => runApp(MultiProvider(
      child: MyApp(),
      providers: [
        FutureProvider<SharedPreferences>(
            create: (BuildContext context) => SharedPreferences.getInstance()),
        ChangeNotifierProvider(
            create: (BuildContext context) => GlobalVariables())
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
      initialRoute: MainView.route,
      routes: {
        Batterie.route: (_) => Batterie(),
        Armortisseur.route: (_) => Armortisseur(),
        Courroie.route: (_) => Courroie(),
        Vidangee.route: (_) => ChangeNotifierProvider(
              create: (BuildContext context) => VidangeLogic(
                  dateViewIndex:
                      Provider.of<GlobalVariables>(context, listen: false)
                          .dateViewIndex,
                  sharedPreferences:
                      Provider.of<SharedPreferences>(context, listen: false)),
              child: Vidangee(),
            ),
        MainView.route: (_) => ChangeNotifierProvider(
            create: (BuildContext context) => MainViewLogic(context: context),
            child: MainView()),
        DateView.route: (_) => ChangeNotifierProvider(
            create: (BuildContext context) => DateViewLogic(
                context: context,
                selectedMainViewElementIndex:
                    Provider.of<GlobalVariables>(context, listen: false)
                        .mainViewIndex,
                sharedPreferences:
                    Provider.of<SharedPreferences>(context, listen: false)),
            child: DateView()),
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
