import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/screens/date_view/date_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List homeList = [
    {'name': 'VIDANGE', 'sharedPrefKey': Constants.vidange},
    {'name': 'COURROIE', 'sharedPrefKey': Constants.courroiePref},
    {'name': 'AMORTISSEUR', 'sharedPrefKey': Constants.amortisseurPref},
//    {'name': 'FRIENAGE', 'sharedPrefKey': Constants.vidange},
    {'name': 'BATTERIE', 'sharedPrefKey': Constants.batteriPref}
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context,
              AsyncSnapshot<SharedPreferences> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('wait'),
              );
            } else {
              SharedPreferences sharedPreferences = snapshot.data;
              if (sharedPreferences.getStringList(Constants.amortisseurPref) !=
                  null) {
                return ListView.builder(
                  itemCount: homeList.length,
                  itemBuilder: (BuildContext context, int index) => ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => DateView(
                              index: index,
                              sharedPreferences: sharedPreferences,
                              sharedPreferencesKey: homeList[index]
                                  ['sharedPrefKey'])));
                    },
                    title: Text(homeList[index]['name']),
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
                        itemCount: homeList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            ListTile(
                          onTap: () {},
                          title: Text(homeList[index]['name']),
                        ),
                      );
                    }
                  },
                );
              }
            }
          },
        ),
      ),
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
