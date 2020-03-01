import 'package:flutter/material.dart';
import 'package:notes/logic/main_view.dart';
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
          ),
          backgroundColor: Colors.orange,
        ),
        body: sharedPreferences == null
            ? Center(
                child: Text('Loading'),
              )
            : ListView.separated(
                itemCount: mainViewLogic.mainViewList.length,
                itemBuilder: (BuildContext context, int index) => Column(
                  children: <Widget>[
                    ListTile(
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      ),
                      onTap: () {
                        mainViewLogic.navigateToDateView(
                          index: index,
                          context: context,
                        );
                      },
                      title: Text(
                        mainViewLogic.mainViewList[index],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ],
                ),
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 2,
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
