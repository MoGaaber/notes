import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/vidange.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:provider/provider.dart';

class DetailsView extends StatelessWidget {
  var test = VidangeModel(
    air: VidangeFilterModel(price: 20, excited: true).toJson(),
    clim: VidangeFilterModel(price: 20, excited: true).toJson(),
    oil: VidangeFilterModel(price: 20, excited: true).toJson(),
    fuel: VidangeFilterModel(price: 20, excited: true).toJson(),
    nextOil: 20,
    km: 20,
    note: '@@@',
    date: '12/12/2020',
  ).toJson();

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
          floatingActionButton: SpeedDial(
            // both default to 16
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(size: 22.0),
            closeManually: false,
            curve: Curves.bounceIn,
            overlayColor: Colors.black,
            overlayOpacity: 0.8,
            onOpen: () => print('OPENING DIAL'),
            onClose: () => print('DIAL CLOSED'),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            elevation: 8.0,
            shape: CircleBorder(),
            children: [
              SpeedDialChild(
                child: Icon(
                  Icons.brush,
                  color: Colors.white,
                ),
                backgroundColor: Colors.green,
                label: 'Edit',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => print('SECOND CHILD'),
              ),
              SpeedDialChild(
                child: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.white,
                ),
                backgroundColor: Colors.red,
                label: 'Delete',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => print('THIRD CHILD'),
              ),
            ],
          ),
          appBar: AppBar(
            title: Text(' Amortisseur Details'),
          ),
          body: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      endIndent: 20,
                      indent: 20,
                    ),
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      subtitle: test.keys.toList()[index] == 'Note'
                          ? Text(test.values.toList()[index])
                          : null,
                      title: Text(
                        test.keys.toList()[index],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      trailing: trailing(index),
                    ),
                    itemCount: test.length,
                  ),
                ),
              ],
            ),
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
      return Material(
        color: values[''] ? Colors.green : Colors.red,
        type: MaterialType.circle,
        child: Icon(
          test.values.toList()[index] ? Icons.check : Icons.close,
          color: Colors.white,
        ),
      );
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
