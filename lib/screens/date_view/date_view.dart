import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/logic/date_view.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/batterie.dart';
import 'package:notes/models/details_view_args.dart';
import 'package:notes/screens/add_or_edit/amortisseur.dart';
import 'package:notes/screens/add_or_edit/batterie.dart';
import 'package:notes/screens/add_or_edit/courroie.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:notes/screens/details_view/details_view.dart';
import 'package:notes/utility/screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateView extends StatefulWidget {
  static const String route = '/dateView';

  @override
  _DateViewState createState() => _DateViewState();
}

class _DateViewState extends State<DateView> with TickerProviderStateMixin {
  Widget empty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Spacer(
          flex: 3,
        ),
        SlideTransition(
          position: slideAnimation,
          child: Center(
            child: Image.asset(
              'assets/images/error.png',
              height: 120,
              color: Colors.orange,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Not found any items here',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text('Add your first one now by clicking on plus button :)'),
        Spacer(
          flex: 6,
        ),
      ],
    );
  }

  GlobalKey globalKey = GlobalKey();
  AnimationController rotateAnimationController;
  Animation<double> rotateAnimation;
  AnimationController scaleAnimationController;
  Animation<double> scaleAnimation;

  AnimationController slideAnimationController;
  Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
/*
    scaleAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    scaleAnimation = Tween<double>(begin: 1, end: 1.1).animate(CurvedAnimation(
        parent: scaleAnimationController, curve: Curves.elasticInOut));

    rotateAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    rotateAnimation =
        Tween<double>(begin: 0, end: 0.5).animate(rotateAnimationController);
*/
    slideAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    slideAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -0.1))
        .animate(CurvedAnimation(
            parent: slideAnimationController, curve: Curves.easeInToLinear));
      slideAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateViewLogic dateViewLogic =
        Provider.of<DateViewLogic>(context, listen: true);
    Globals globals = Provider.of<Globals>(context, listen: false);
    double height = globals.screen.height;
    double width = globals.screen.width;
    double aspectRatio = globals.screen.aspectRatio;
    double textScale = globals.screen.textScale;
    Screen screen = globals.screen;
    print(globals.addOrEditPages[globals.mainViewIndex]['icon']);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                size: 30 /
                    globals.screen.aspectRatio *
                    globals.screen.aspectRatio,
                color: Colors.white,
              ),
              onPressed: () {
                dateViewLogic.navigateToSave(context: context, index: null);
              },
            )
          ],
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/images/${globals.addOrEditPages[globals.mainViewIndex]['icon']}',
                color: Colors.white,
                width: screen.convert(50, width),
                height: screen.convert(30, height),
                fit: BoxFit.fitHeight,
              ),
              Text(globals.addOrEditPages[globals.mainViewIndex]['name'],
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        body: dateViewLogic.list == null
            ? FutureBuilder<bool>(
                future: dateViewLogic.sharedPreferences
                    .setStringList(dateViewLogic.mKey, []),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return empty();
                  } else {
                    return Center(
                      child: Text('!'),
                    );
                  }
                },
              )
            : dateViewLogic.list.length == 0
                ? empty()
                : ScrollConfiguration(
                    behavior: ScrollBehavior(),
                    child: ListView.separated(
                      reverse: false,
                      padding: EdgeInsets.only(
                          top: 1 /
                              globals.screen.height *
                              globals.screen.height),
                      itemCount: dateViewLogic.list.length,
                      itemBuilder: (BuildContext context, int index) =>
                          Dismissible(
                        key: GlobalKey(debugLabel: index.toString()),
                        onDismissed: (x) {
                          dateViewLogic.deleteItem(index: index);
                        },
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              contentPadding: EdgeInsets.all(
                                screen.convert(10, aspectRatio),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () async {
                                      var result = await Navigator.pushNamed(
                                          context,
                                          globals.addOrEditPages[
                                              globals.mainViewIndex]['route']);
                                      if (result != null) {
                                        dateViewLogic.list[index] = result;
                                        dateViewLogic.notifyListeners();
                                      }
                                    },
                                    child: SizedBox(
                                      height: screen.convert(50, height),
                                      width: screen.convert(50, width),
                                      child: Material(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Colors.green,
                                        type: MaterialType.canvas,
                                        child: Icon(
                                          Icons.mode_edit,
                                          size: 30 / aspectRatio * aspectRatio,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              screen.convert(5, screen.width))),
                                  InkWell(
                                    onTap: () async {
                                      globals.dateViewIndex = index;
                                      var result = await Navigator.pushNamed(
                                          context, DetailsView.route,
                                          arguments: DetailsViewModelArgs(
                                              jsonDecode(
                                                  dateViewLogic.list[index]),
                                              index));
                                      print(result.toString() + 'hello');
                                      if (result != null) {
                                        dateViewLogic.list[index] =
                                            jsonEncode(result);
                                        dateViewLogic.notifyListeners();
                                      }
                                    },
                                    child: SizedBox(
                                      height: screen.convert(50, height),
                                      width: screen.convert(50, width),
                                      child: Material(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Colors.orange,
                                        type: MaterialType.canvas,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 30 / aspectRatio * aspectRatio,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              leading: InkWell(
                                onTap: () {
                                  dateViewLogic.deleteItem(index: index);
                                },
                                child: Material(
                                  color: Colors.red,
                                  type: MaterialType.circle,
                                  child: Icon(
                                    Icons.remove,
                                    size: 40 / aspectRatio * aspectRatio,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              title: Text(
                                jsonDecode(dateViewLogic.list[index])['Date'],
                              ),
                            ),
                            index == 0
                                ? Divider(
                                    height: 20 / height * height,
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        height: 20 / height * height,
                      ),
                    ),
                  ),
      ),
    );
  }
}
/*
/*
            RotationTransition(
              child: IconButton(
                  icon: Icon(Icons.arrow_upward),
                  onPressed: () {
                    if (rotateAnimation.isCompleted) {
                      rotateAnimationController.reverse();
                      dateViewLogic.list = dateViewLogic.list.reversed.toList();
                    } else {
                      rotateAnimationController.forward();
                      dateViewLogic.list = dateViewLogic.list.reversed.toList();
                    }
                    dateViewLogic.notifyListeners();
                  }),
              turns: rotateAnimation,
            ),
*/
 */
