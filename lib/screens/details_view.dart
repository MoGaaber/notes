import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/logic/details_view.dart';
import 'package:notes/logic/globals.dart';
import 'package:provider/provider.dart';

class DetailsView extends StatelessWidget {
  static const route = '/details';
  bool isResult = false;

  @override
  Widget build(BuildContext context) {
    Globals globals = Provider.of<Globals>(context, listen: false);

    DetailsViewLogic detailsView = Provider.of<DetailsViewLogic>(context);
    print(detailsView.decodedData);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(
                    context, isResult ? detailsView.decodedData : null);
              },
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    var result = await Navigator.pushNamed(
                        context,
                        globals.addOrEditPages[detailsView.mainViewIndex]
                            ['route']);
                    if (result != null) {
                      this.isResult = true;

                      print('result');
                      detailsView.decodedData = jsonDecode(result);
                    }
                  }),
            ],
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/images/${globals.addOrEditPages[detailsView.mainViewIndex]['icon']}',
                  color: Colors.white,
                  width: globals.screen.convert(50, globals.width),
                  height: globals.screen.convert(30, globals.height),
                  fit: BoxFit.fitHeight,
                ),
                Text(globals.addOrEditPages[detailsView.mainViewIndex]['name'],
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          body: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: ListView.separated(
                itemCount: detailsView.decodedData.keys.toList().length,
                padding: EdgeInsets.only(
                    top: globals.screen.convert(5, globals.height)),
                itemBuilder: (BuildContext context, int x) {
                  return detailsView.decodedData[
                          detailsView.decodedData.keys.toList()[x]] is Map
                      ? ExpandablePanel(
                          theme: ExpandableThemeData(iconColor: Colors.orange),
                          expanded: Column(children: <Widget>[
                            for (var key in detailsView
                                .decodedData[
                                    detailsView.decodedData.keys.toList()[x]]
                                .keys)
                              if (detailsView.decodedData[detailsView
                                      .decodedData.keys
                                      .toList()[x]][key] !=
                                  null)
                                ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 30),
                                  trailing: detailsView.decodedData[detailsView
                                          .decodedData.keys
                                          .toList()[x]][key] is bool
                                      ? Material(
                                          color: detailsView.decodedData[
                                                  detailsView.decodedData.keys
                                                      .toList()[x]][key]
                                              ? Colors.green
                                              : Colors.red,
                                          type: MaterialType.circle,
                                          child: Icon(
                                            detailsView.decodedData[detailsView
                                                    .decodedData.keys
                                                    .toList()[x]][key]
                                                ? Icons.check
                                                : Icons.close,
                                            color: Colors.white,
                                            size: globals.screen.convert(
                                                24, globals.aspectRatio),
                                          ),
                                        )
                                      : Text(
                                          detailsView.decodedData[detailsView
                                                  .decodedData.keys
                                                  .toList()[x]][key]
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: globals.screen.convert(
                                                  18, globals.textScaleFactor),
                                              fontWeight: FontWeight.w700,
                                              color: Colors.green),
                                        ),
                                  title: Text(
                                    key.toString(),
                                    style: TextStyle(
//                                        color: Colors.orange,
                                        fontSize: globals.screen.convert(
                                            21, globals.textScaleFactor),
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                          ]),
                          header: ListTile(
                            title: Text(
                              detailsView.decodedData.keys.toList()[x],
                            ),
                          ),
                        )
                      : detailsView.decodedData[
                                  detailsView.decodedData.keys.toList()[x]] ==
                              ''
                          ? Container()
                          : ListTile(
                              trailing: detailsView.decodedData[detailsView
                                      .decodedData.keys
                                      .toList()[x]] is bool
                                  ? Material(
                                      color: detailsView.decodedData[detailsView
                                              .decodedData.keys
                                              .toList()[x]]
                                          ? Colors.green
                                          : Colors.red,
                                      type: MaterialType.circle,
                                      child: Icon(
                                        detailsView.decodedData[detailsView
                                                .decodedData.keys
                                                .toList()[x]]
                                            ? Icons.check
                                            : Icons.close,
                                        color: Colors.white,
                                        size: globals.screen
                                            .convert(24, globals.aspectRatio),
                                      ),
                                    )
                                  : detailsView.decodedData.keys.toList()[x] ==
                                          'Note'
                                      ? null
                                      : Text(
                                          detailsView.decodedData[detailsView
                                                  .decodedData.keys
                                                  .toList()[x]]
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: globals.screen.convert(
                                                  20, globals.textScaleFactor),
                                              fontWeight: FontWeight.w700,
                                              color: Colors.green),
                                        ),
                              title: Text(
                                detailsView.decodedData.keys.toList()[x],
                                style: TextStyle(
                                    fontSize: globals.screen
                                        .convert(25, globals.textScaleFactor),
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle:
                                  detailsView.decodedData.keys.toList()[x] ==
                                          'Note'
                                      ? Text(
                                          detailsView.decodedData[detailsView
                                              .decodedData.keys
                                              .toList()[x]],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.green,
                                              fontSize: globals.screen.convert(
                                                  20, globals.textScaleFactor)),
                                        )
                                      : null,
                            );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                }),
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
