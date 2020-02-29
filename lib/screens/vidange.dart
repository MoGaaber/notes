/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Vidange extends StatefulWidget {
  Vidange({Key key}) : super(key: key);

  @override
  _VidangeState createState() => _VidangeState();
}

class _VidangeState extends State<Vidange> {
  List<Map<String, dynamic>> vindaheList = [];
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('hello world');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Vidbage')),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Vidnage();
              }));
            }),
        body: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (BuildContext context,
                AsyncSnapshot<SharedPreferences> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('hello'),
                );
              } else {
                SharedPreferences sharedPreferences = snapshot.data;
                var list = sharedPreferences.getStringList('Vidange');
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return EditVidnage(jsonDecode(list[index]));
                                }));
                              }),
                        ),
                        title: Text(
                          jsonDecode(list[index])['airFilter'].toString(),
                        ),
                        subtitle: Text('vindaheList[index].date'),
                        trailing: GestureDetector(
                          child: Icon(
                            Icons.delete,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            list.removeAt(index);
                            var newList = list;
                            sharedPreferences.setStringList('Vidange', newList);

                            setState(() {});
                          },
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                );
              }
            }));
  }
}

class CardModel {
  TextEditingController textEditingController;
  bool dropDownButtonValue;
  CardModel({this.textEditingController, this.dropDownButtonValue});
}

// ///////////////
class Vidnage extends StatefulWidget {
  Vidnage({Key key}) : super(key: key);

  @override
  _VidnageState createState() => _VidnageState();
}

class _VidnageState extends State<Vidnage> {
  Future<Null> _selectDate(BuildContext context, time) async {
    DateTime picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2020, 1, 1),
      maxTime: DateTime(2022, 6, 7),
      onChanged: (date) {
        print('change $date');
      },
      onConfirm: (date) {
        print('confirm ${DateFormat('yyyy-MM-dd').format(date)}');
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
    setState(() {
      time = picked;
    });
  }

  var _valueDropTown = '1';
  double sliderValue = 0;
  DateTime date = DateTime.now();
  List<TextEditingController> controllers;
  List<int> dropValues;
  List<CardModel> cards;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllers = List.filled(4, TextEditingController());
    dropValues = List.filled(4, 0);
    cards = List.generate(
        4,
        (ind) => CardModel(
            textEditingController: TextEditingController(),
            dropDownButtonValue: false));
    initPreference();
  }

  SharedPreferences sharedPreferences;
  void initPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getStringList('Vidange'));
    if (sharedPreferences.getStringList('Vidange') == null) {
      print('hello');
      sharedPreferences.setStringList('Vidange', []);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(sharedPreferences.getStringList('Vidange'));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Vidnage'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                var oldList = sharedPreferences.getStringList('Vidange');
                oldList.add(jsonEncode(VidangeModel(
                  km: sliderValue,
                  airFilterPrice:
                      int.parse(this.cards[0].textEditingController.text),
                  airFilter: this.cards[0].dropDownButtonValue,
                  oilFilter: this.cards[1].dropDownButtonValue,
                  oilFilterPrice:
                      int.parse(this.cards[1].textEditingController.text),
                  fuelFilter: this.cards[2].dropDownButtonValue,
                  fuelFilterPrice:
                      int.parse(this.cards[2].textEditingController.text),
                  climFilter: this.cards[3].dropDownButtonValue,
                  climFilterPrice:
                      int.parse(this.cards[3].textEditingController.text),
                ).toJson()));
                var newList = oldList;
                sharedPreferences.setStringList('Vidange', newList);
              },
              icon: Icon(Icons.check),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: ListView(
            children: <Widget>[
              */
/*    FlatButton(
                  onPressed: () {
                    _selectDate(context, date);
                  },
                  child: Text('Date:$date',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ))),
              FlatButton(
                  onPressed: () {
                    _selectDate(context, date);
                  },
                  child: Text('Next Oil Change:$date',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ))),*/ /*

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CircleAvatar(
                    maxRadius: 30, child: Text('Km ${sliderValue.toInt()}'))
              ]),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Slider(
                    min: 0,
                    max: 100,
                    value: sliderValue,
                    onChanged: (value) {
                      setState(() {
                        sliderValue = value;
                      });
                    }),
              ),
              buildContainer('Air Filter', 0),
              buildContainer('oil Filter', 1),
              buildContainer('fuel Filter', 2),
              buildContainer('clim Filter', 3),
*/
/*
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Save button clicked");
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Delete',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Delete button clicked");
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
*/ /*

            ],
          ),
        ),
      ),
    );
  }

  Container buildContainer(title, int index) {
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            Text(title),
            SizedBox(width: 50),
            DropdownButton<bool>(
              items: [
                DropdownMenuItem<bool>(
                  value: false,
                  child: Text(
                    "yes",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                DropdownMenuItem<bool>(
                  value: true,
                  child: Text(
                    "no",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
              onChanged: (value) {
                print(index);
                setState(() {
                  this.cards[index].dropDownButtonValue = value;
                  print(value);
                });
              },
              value: this.cards[index].dropDownButtonValue,
              elevation: 2,
              style: TextStyle(color: Colors.purple, fontSize: 30),
              isDense: true,
              iconSize: 30.0,
            ),
            Expanded(
              child: TextField(
                  controller: this.cards[index].textEditingController,
                  decoration: new InputDecoration(labelText: "Price "),
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly]),
            ),
          ],
        ),
      ),
    );
  }
}

class EditVidnage extends StatefulWidget {
  Map map;
  EditVidnage(this.map);

  @override
  _EditVidnageState createState() => _EditVidnageState();
}

class _EditVidnageState extends State<EditVidnage> {
  Future<Null> _selectDate(BuildContext context, time) async {
    DateTime picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2020, 1, 1),
      maxTime: DateTime(2022, 6, 7),
      onChanged: (date) {
        print('change $date');
      },
      onConfirm: (date) {
        print('confirm ${DateFormat('yyyy-MM-dd').format(date)}');
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
    setState(() {
      time = picked;
    });
  }

  var _valueDropTown = '1';
  double sliderValue = 0;
  DateTime date = DateTime.now();
  List<TextEditingController> controllers;
  List<int> dropValues;
  List<CardModel> cards;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllers = List.filled(4, TextEditingController());
    dropValues = List.filled(4, 0);
    cards = List.generate(
        4,
        (ind) => CardModel(
            textEditingController: TextEditingController(),
            dropDownButtonValue: false));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.map);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Vidnage'),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.check),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: ListView(
            children: <Widget>[
              */
/*    FlatButton(
                  onPressed: () {
                    _selectDate(context, date);
                  },
                  child: Text('Date:$date',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ))),
              FlatButton(
                  onPressed: () {
                    _selectDate(context, date);
                  },
                  child: Text('Next Oil Change:$date',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ))),*/ /*

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CircleAvatar(
                    maxRadius: 30, child: Text('Km ${sliderValue.toInt()}'))
              ]),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Slider(
                    min: 0,
                    max: 100,
                    value: widget.map['km'],
                    onChanged: (value) {
                      setState(() {
                        widget.map['km'] = value;
                      });
                    }),
              ),
              buildContainer('Air Filter', 0),
              buildContainer('oil Filter', 1),
              buildContainer('fuel Filter', 2),
              buildContainer('clim Filter', 3),
*/
/*
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Save button clicked");
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Delete',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Delete button clicked");
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
*/ /*

            ],
          ),
        ),
      ),
    );
  }

  Container buildContainer(title, int index) {
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            Text(title),
            SizedBox(width: 50),
            DropdownButton<bool>(
              items: [
                DropdownMenuItem<bool>(
                  value: false,
                  child: Text(
                    "yes",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                DropdownMenuItem<bool>(
                  value: true,
                  child: Text(
                    "no",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
              onChanged: (value) {
                print(index);
                setState(() {
                  this.cards[index].dropDownButtonValue = value;
                  print(value);
                });
              },
              value: this.cards[index].dropDownButtonValue,
              elevation: 2,
              style: TextStyle(color: Colors.purple, fontSize: 30),
              isDense: true,
              iconSize: 30.0,
            ),
            Expanded(
              child: TextField(
                  controller: this.cards[index].textEditingController,
                  decoration: new InputDecoration(labelText: "Price "),
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly]),
            ),
          ],
        ),
      ),
    );
  }
}

class VidangeModel {
  double km;
  bool airFilter;
  int airFilterPrice;
  bool oilFilter;
  int oilFilterPrice;
  bool fuelFilter;
  int fuelFilterPrice;
  bool climFilter;
  int climFilterPrice;
  @JsonSerializable(nullable: false)
  VidangeModel({
    this.km,
    this.airFilterPrice,
    this.airFilter,
    this.oilFilterPrice,
    this.oilFilter,
    this.fuelFilter,
    this.fuelFilterPrice,
    this.climFilter,
    this.climFilterPrice,
  });

  Map<String, dynamic> toJson() => {
        'km': km,
        'airFilterPrice': airFilterPrice,
        'airFilter': airFilter,
        'oilFilterPrice': oilFilterPrice,
        'oilFilter': oilFilter,
        'fuelFilter': fuelFilter,
        'fuelFilterPrice': fuelFilterPrice,
        'climFilter': climFilter,
        'climFilterPrice': climFilterPrice,
      };
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
*/
