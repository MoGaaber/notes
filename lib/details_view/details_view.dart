import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/amortisseur.dart';
import 'package:notes/models/frienage.dart';
import 'package:notes/models/vidange.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:provider/provider.dart';

class DetailsView extends StatelessWidget {
  var test = ArmortisseurModel(
          front: true, rear: false, km: 20, date: '!!', note: '!!!!')
      .toJson();
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
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(icon: Icon(Icons.brush), onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Delete confirmation'),
                              content: Text('Are you sure ?!'),
                              backgroundColor: Colors.white,
                              actions: <Widget>[
                                FlatButton(
                                    textColor: Colors.orange,
                                    onPressed: () {},
                                    child: Text('Yes')),
                                FlatButton(
                                  onPressed: () {},
                                  child: Text('No'),
                                  textColor: Colors.orange,
                                )
                              ],
                            ));
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
                for (var x in test.keys)
                  test[x] is Map
                      ? ExpansionTile(
                          children: <Widget>[
                            for (var key in test[x].keys)
                              if (test[x][key] != null)
                                ListTile(
                                  trailing: test[x][key] is bool
                                      ? Material(
                                          color: test[x][key]
                                              ? Colors.green
                                              : Colors.red,
                                          type: MaterialType.circle,
                                          child: Icon(
                                            test[x][key]
                                                ? Icons.check
                                                : Icons.close,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          test[x][key].toString(),
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
                          trailing: test[x] is bool
                              ? Material(
                                  color: test[x] ? Colors.green : Colors.red,
                                  type: MaterialType.circle,
                                  child: Icon(
                                    test[x] ? Icons.check : Icons.close,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  test[x].toString(),
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
                        )
              ],
            ),
/*
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(
                endIndent: 20,
                indent: 20,
              ),
              itemBuilder: (BuildContext context, int index) =>

*/
/*
                  ListTile(
                subtitle: test.keys.toList()[index] == 'Note'
                    ? Text(test.values.toList()[index])
                    : null,
                title: Text(
                  test.keys.toList()[index],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                trailing: trailing(index),
              ),
*/ /*

                  Column(
                children: <Widget>[Text('Disc Frien',)],
              ),
              itemCount: test.length,
            ),
*/
          )),
    );
  }

  Widget trailing(int index) {
    var values = test.values.toList()[index];
    if (values is bool) {
      return Material(
        color: test.values.toList()[index] ? Colors.green : Colors.red,
        type: MaterialType.circle,
        child: Icon(
          test.values.toList()[index] ? Icons.check : Icons.close,
          color: Colors.white,
        ),
      );
    } else if (values is String ||
        values is num && test.keys.toList()[index] != 'Note') {
      return Text(test.values.toList()[index].toString());
    } else if (values is Map) {
/*
      return Material(
        color: values[''] ? Colors.green : Colors.red,
        type: MaterialType.circle,
        child: Icon(
          test.values.toList()[index] ? Icons.check : Icons.close,
          color: Colors.white,
        ),
      );
*/
    }
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
