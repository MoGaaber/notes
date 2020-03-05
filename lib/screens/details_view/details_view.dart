import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/amortisseur.dart';
import 'package:notes/models/details_view_args.dart';
import 'package:notes/models/frienage.dart';
import 'package:notes/models/vidange.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:notes/utility/screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsView extends StatefulWidget {
  static const route = '/details';

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  Map<String, dynamic> data;

  bool expanded = false;
  int expandedIndex;

  @override
  Widget build(BuildContext context) {
/*
    var test = {
      'Date': '12/12/2020',
      'KM': '55555665',
      'Rear / AV': true,
      'Front / AV': false,
      'Note':
          'this.notethis.notethis.notethis.notethis.notethis.notethis.notethis.notethis.notethis.notethis.notethis.notethis.notethis.notethis.note',
    };
*/
    final DetailsViewModelArgs args = ModalRoute.of(context).settings.arguments;
    SharedPreferences sharedPreferences =
        Provider.of<SharedPreferences>(context);
    this.data = args.data;

    print(data);
    Globals globals = Provider.of<Globals>(context, listen: false);

    double height = globals.screen.height;
    double width = globals.screen.width;
    double aspectRatio = globals.screen.aspectRatio;
    double textScale = globals.screen.textScale;
    Screen screen = globals.screen;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(icon: Icon(Icons.brush), onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {
/*
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Delete confirmation'),
                              content: Text('Are you sure ?!'),
                              backgroundColor: Colors.white,
                              actions: <Widget>[
                                FlatButton(
                                    textColor: Colors.orange,
                                    onPressed: () {
                                      Globals globals =
                                          Provider.of(context, listen: false);
                                      var list = sharedPreferences
                                          .getStringList(globals.addOrEditPages[
                                              globals.mainViewIndex]['refKey']);
                                      print(list);
                                      list.removeAt(globals.dateViewIndex);
                                      print(list);
                                      sharedPreferences
                                          .setStringList(
                                              globals.sharedPrefKey, list)
                                          .then((x) {});
                                    },
                                    child: Text('Yes')),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('No'),
                                  textColor: Colors.orange,
                                )
                              ],
                            ));
*/
/*
                    Globals globals = Provider.of(context, listen: false);
                    var list = sharedPreferences.getStringList(globals
                        .addOrEditPages[globals.mainViewIndex]['refKey']);
                    print(globals.mainViewIndex.toString() + '!!!!');
                    list.removeAt(globals.dateViewIndex);
                    sharedPreferences
                        .setStringList(
                            globals.addOrEditPages[globals.mainViewIndex]
                                ['refKey'],
                            list)
                        .then((x) {
                      Navigator.pop(context);
                    });
*/
                  }),
            ],
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Image.asset(
              'assets/images/fuel.png',
              color: Colors.white,
              width: screen.convert(50, width),
              height: screen.convert(30, height),
              fit: BoxFit.fitHeight,
            ),
          ),
          body: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: ListView.separated(
              itemCount: data.keys.toList().length,
              padding: EdgeInsets.only(top: screen.convert(5, height)),
              itemBuilder: (BuildContext context, int x) {
                return data[data.keys.toList()[x]] is Map
                    ? ExpansionTile(
                        onExpansionChanged: (expanded) {
                          expandedIndex = x;

                          print(expandedIndex);
                          this.expanded = expanded;
                          setState(() {});
                        },
                        children: <Widget>[
                          for (var key in data[data.keys.toList()[x]].keys)
                            if (data[data.keys.toList()[x]][key] != null)
                              ListTile(
                                trailing: data[data.keys.toList()[x]][key]
                                        is bool
                                    ? Material(
                                        color: data[data.keys.toList()[x]][key]
                                            ? Colors.green
                                            : Colors.red,
                                        type: MaterialType.circle,
                                        child: Icon(
                                          data[data.keys.toList()[x]][key]
                                              ? Icons.check
                                              : Icons.close,
                                          color: Colors.white,
                                          size: screen.convert(24, aspectRatio),
                                        ),
                                      )
                                    : Text(
                                        data[data.keys.toList()[x]][key]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize:
                                                screen.convert(18, textScale),
                                            fontWeight: FontWeight.w700,
                                            color: Colors.green),
                                      ),
                                title: Text(
                                  key.toString(),
                                  style: TextStyle(
                                      fontSize: screen.convert(17, textScale),
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                        ],
                        title: Text(
                          data.keys.toList()[x],
                          style: TextStyle(
                              fontSize: screen.convert(20, textScale),
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    : ListTile(
                        trailing: data[x] is bool
                            ? Material(
                                color: data[x] ? Colors.green : Colors.red,
                                type: MaterialType.circle,
                                child: Icon(
                                  data[x] ? Icons.check : Icons.close,
                                  color: Colors.white,
                                  size: screen.convert(24, aspectRatio),
                                ),
                              )
                            : data.keys.toList()[x] == 'Note'
                                ? null
                                : Text(
                                    data[x].toString(),
                                    style: TextStyle(
                                        fontSize: screen.convert(20, textScale),
                                        fontWeight: FontWeight.w700,
                                        color: Colors.green),
                                  ),
                        title: Text(
                          data.keys.toList()[x],
                          style: TextStyle(
                              fontSize: screen.convert(25, textScale),
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: data.keys.toList()[x] == 'Note'
                            ? Text(
                                data.keys.toList()[x],
                              )
                            : null,
                      );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          )),
    );
  }
}
/*
      children: <Widget>[

                ListTile(
                  title: Text(
                    'Date',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  trailing: Text(
                    '12 / 12 / 2015',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ),
                Divider(
                  endIndent: 20,
                  indent: 20,
                ),
                ListTile(
                  title: Text(
                    'KM',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  trailing: Text(
                    '70',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ),
                Divider(
                  endIndent: 20,
                  indent: 20,
                ),

                Divider(
                  endIndent: 20,
                  indent: 20,
                ),
                ListTile(
                  title: Text(
                    'Rear / AV',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  trailing: Material(
                    color: Colors.green,
                    type: MaterialType.circle,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Note',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                          'I think the most straightforward way of doing this is to adjust the title color for the theme that you are working with:')),
                )
              ],
 */
