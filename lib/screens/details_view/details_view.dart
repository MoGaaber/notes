import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/amortisseur.dart';
import 'package:notes/models/details_view_args.dart';
import 'package:notes/models/frienage.dart';
import 'package:notes/models/vidange.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsView extends StatelessWidget {
  Map<String, dynamic> data;
/*
  var test = VidangeModel(
          note: 'helloo',
          date: '12/12/1212',
          km: 20,
          nextOil: 20,
          oil: VidangeFilterModel(excited: true, price: 12),
          air: VidangeFilterModel(excited: false, price: null),
          fuel: VidangeFilterModel(excited: false, price: 2222),
          clim: VidangeFilterModel(price: 222, excited: false))
      .toJson();

  var test = FrienageModel(
          date: '12/12/2020',
          secondInnerModel: InnerModel(km: 12, rear: true, front: false),
          firstInnerModel: InnerModel(km: 12, rear: true, front: false))
      .toJson();


      */

  static const route = '/details';
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
                    Globals globals = Provider.of(context, listen: false);
                    var list = sharedPreferences.getStringList(globals
                        .addOrEditPages[globals.mainViewIndex]['refKey']);
                    print(list);
                    list.removeAt(globals.dateViewIndex);
                    print(list);
                    sharedPreferences
                        .setStringList(globals.sharedPrefKey, list)
                        .then((x) {});
                  }),
            ],
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'Amortisseur Details',
              style: TextStyle(fontSize: 19.5),
            ),
          ),
          body: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: ListView(
              padding: EdgeInsets.only(top: 5),
              children: <Widget>[
                for (var x in data.keys)
                  data[x] is Map
                      ? ExpansionTile(
                          children: <Widget>[
                            for (var key in data[x].keys)
                              if (data[x][key] != null)
                                ListTile(
                                  trailing: data[x][key] is bool
                                      ? Material(
                                          color: data[x][key]
                                              ? Colors.green
                                              : Colors.red,
                                          type: MaterialType.circle,
                                          child: Icon(
                                            data[x][key]
                                                ? Icons.check
                                                : Icons.close,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          data[x][key].toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.green),
                                        ),
                                  title: Text(
                                    key.toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                          ],
                          title: Text(
                            x,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
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
                                  ),
                                )
                              : x == 'Note'
                                  ? null
                                  : Text(
                                      data[x].toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.green),
                                    ),
                          title: Text(
                            x,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          subtitle: x == 'Note' ? Text(data[x]) : null,
                        )
              ],
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
