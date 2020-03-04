import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/logic/main_view.dart';
import 'package:notes/models/vidange.dart';
import 'package:notes/utility/screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainView extends StatelessWidget {
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    SharedPreferences sharedPreferences =
        Provider.of<SharedPreferences>(context, listen: true);
    MainViewLogic mainViewLogic =
        Provider.of<MainViewLogic>(context, listen: false);
    Globals globals = Provider.of<Globals>(context, listen: false);
    globals.screen = Screen(
        size: MediaQuery.of(context).size,
        textScale: MediaQuery.textScaleFactorOf(context));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Home',
          ),
          backgroundColor: Colors.orange,
        ),
        body: sharedPreferences == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: ListView.separated(
                  itemCount: mainViewLogic.globals.addOrEditPages.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.all(10 /
                            globals.screen.aspectRatio *
                            globals.screen.aspectRatio),
                        leading: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            SizedBox(
                                height: 80,
                                width: 50,
                                child: Material(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.orange.withOpacity(0.8),
                                )),
                            Image.asset(
                              'assets/images/${mainViewLogic.globals.addOrEditPages[index]['icon']}',
                              width: 35 /
                                  globals.screen.width *
                                  globals.screen.width,
                              color: Colors.white,
                              height: 35 /
                                  globals.screen.height *
                                  globals.screen.height,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20 /
                              globals.screen.aspectRatio *
                              globals.screen.aspectRatio,
                          color: Colors.orange,
                        ),
                        onTap: () {
                          mainViewLogic.navigateToDateView(
                            index: index,
                            context: context,
                          );
                        },
                        title: Text(
                          mainViewLogic.globals.addOrEditPages[index]['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20 /
                                  globals.screen.textScale *
                                  globals.screen.textScale),
                        ),
                      ),
                    ],
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                ),
              ),
/*
        body: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context,
              AsyncSnapshot<SharedPreferences> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('wait'),
              );
            } else {
              sharedPreferences = snapshot.data;
              if (sharedPreferences.getStringList(Constants.amortisseurPref) !=
                  null) {
                return ListView.builder(
                  itemCount: mainLogic.list.length,
                  itemBuilder: (BuildContext context, int index) => ListTile(
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => DateView(
                              index: index,
                              sharedPreferences: sharedPreferences,
                              sharedPreferencesKey: mainLogic.list[index]
                                  ['sharedPrefKey'])));
                    },
                    title: Text(mainLogic.list[index]['name']),
                  ),
                );
              } else {
                return FutureBuilder<List<bool>>(
                  future: Future.wait([
                    sharedPreferences
                        .setStringList(Constants.amortisseurPref, []),
                    sharedPreferences.setStringList(Constants.batteriPref, []),
                    sharedPreferences.setStringList(Constants.courroiePref, []),
                    sharedPreferences.setStringList(Constants.vidange, []),
                  ]),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<bool>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text('waiting'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: mainLogic.list.length,
                        itemBuilder: (BuildContext context, int index) =>
                            ListTile(
                          onTap: () {},
                          title: Text(mainLogic.list[index]['name']),
                        ),
                      );
                    }
                  },
                );
              }
            }
          },
        ),
*/
      ),
    );
  }
}
