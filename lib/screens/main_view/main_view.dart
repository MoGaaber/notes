import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/logic/main_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainView extends StatelessWidget {
  static const String route = '/';
  Widget body() {}
  @override
  Widget build(BuildContext context) {
    SharedPreferences sharedPreferences =
        Provider.of<SharedPreferences>(context, listen: true);
    Globals globals = Provider.of<Globals>(context, listen: false);
    MainViewLogic mainViewLogic =
        Provider.of<MainViewLogic>(context, listen: false);
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
                child: Text('Loading'),
              )
            : ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: sharedPreferences.getStringList(Constants.vidangePref) ==
                        null
                    ? FutureBuilder(
                        future: Future.wait([
                          sharedPreferences
                              .setStringList(Constants.amortisseurPref, []),
                          sharedPreferences
                              .setStringList(Constants.batteriPref, []),
                          sharedPreferences
                              .setStringList(Constants.courroiePref, []),
                          sharedPreferences
                              .setStringList(Constants.vidangePref, []),
                          sharedPreferences
                              .setStringList(Constants.frenagePref, []),
                        ]),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return ListView.separated(
                            itemCount: globals.addOrEditPages.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Column(
                              children: <Widget>[
                                ListTile(
                                  contentPadding: EdgeInsets.all(10),
                                  leading: Image.asset(
                                    'assets/images/${globals.addOrEditPages[index]['icon']}',
                                    width: index == 0 ? 50 : 35,
                                    height: index == 0 ? 50 : 35,
                                    fit: BoxFit.cover,
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Colors.orange,
                                  ),
                                  onTap: () {
                                    mainViewLogic.navigateToDateView(
                                      index: index,
                                      context: context,
                                    );
                                  },
                                  title: Text(
                                    globals.addOrEditPages[index]['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(
                              indent: 30,
                            ),
                          );
                        },
                      )
                    : ListView.separated(
                        itemCount: globals.addOrEditPages.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Column(
                          children: <Widget>[
                            ListTile(
                              contentPadding: EdgeInsets.all(10),
                              leading: Image.asset(
                                'assets/images/${globals.addOrEditPages[index]['icon']}',
                                width: index == 0 ? 50 : 35,
                                height: index == 0 ? 50 : 35,
                                fit: BoxFit.cover,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.orange,
                              ),
                              onTap: () {
                                mainViewLogic.navigateToDateView(
                                  index: index,
                                  context: context,
                                );
                              },
                              title: Text(
                                globals.addOrEditPages[index]['name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          indent: 30,
                        ),
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
