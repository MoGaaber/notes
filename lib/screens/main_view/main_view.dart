import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/main.dart';
import 'package:notes/logic/root.dart';
import 'package:notes/screens/date_view/date_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainView extends StatelessWidget {
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    SharedPreferences sharedPreferences =
        Provider.of<SharedPreferences>(context, listen: true);
    MainLogic mainLogic = Provider.of<MainLogic>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: sharedPreferences == null
            ? Center(
                child: Text('Loading'),
              )
            : ListView.builder(
                itemCount: mainLogic.list.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  onTap: () {
                    mainLogic.navigateToDateView(
                      index: index,
                      context: context,
                    );
                  },
                  title: Text(mainLogic.list[index]['name']),
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
