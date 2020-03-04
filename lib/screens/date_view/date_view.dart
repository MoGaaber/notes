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
    scaleAnimationController.dispose();
    slideAnimationController.dispose();
    rotateAnimationController.dispose();
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
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
          title: Text(
            globals.addOrEditPages[globals.mainViewIndex]['name'],
            style: TextStyle(
              color: Colors.white,
            ),
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
                        child: Stack(
                          children: <Widget>[
                            ListTile(
                              onTap: () {
                                globals.dateViewIndex = index;
                                var result = Navigator.pushNamed(
                                    context, DetailsView.route,
                                    arguments: DetailsViewModelArgs(
                                        jsonDecode(dateViewLogic.list[index]),
                                        index));
                              },
                              title: Text(
                                jsonDecode(dateViewLogic.list[index])['Date'],
                                style: TextStyle(
                                    fontSize: 30 / textScale * textScale,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment(0.9, 0),
                                child: InkWell(
                                  onTap: () {
                                    dateViewLogic.deleteItem(index: index);
                                  },
                                  child: Material(
                                    color: Colors.red,
                                    type: MaterialType.circle,
                                    child: Icon(
                                      Icons.remove,
                                      size: 30 / aspectRatio * aspectRatio,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
