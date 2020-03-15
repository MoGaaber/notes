import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/logic/date_view.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/models/date_view_args.dart';
import 'package:notes/utility/screen.dart';
import 'package:provider/provider.dart';

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
        Text('Add your first one now by clicking on below button :)'),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: ButtonTheme(
            height: 50,
            minWidth: 200,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              color: Colors.orange,
              onPressed: () {
                dateViewLogic.addItem(context);
              },
              child: Text(
                'Add ${dateViewLogic.globals.addOrEditPages[dateViewLogic.mainViewIndex]['name']}',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
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
  DateViewLogic dateViewLogic;
  @override
  void initState() {
    super.initState();
    dateViewLogic = Provider.of<DateViewLogic>(context, listen: false);
    slideAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    slideAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -0.1))
        .animate(CurvedAnimation(
            parent: slideAnimationController, curve: Curves.easeInToLinear));
//    slideAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Globals globals = Provider.of<Globals>(context, listen: false);
    double height = globals.screen.height;
    Screen screen = globals.screen;

    DateViewArgs dateViewArgs = ModalRoute.of(context).settings.arguments;
    int mainViewIndex = dateViewArgs.index;
    if (mainViewIndex != dateViewLogic.mainViewIndex)
      dateViewLogic.initialize(mainViewIndex);

    return Consumer<DateViewLogic>(
      builder: (BuildContext context, DateViewLogic value, Widget child) =>
          SafeArea(
        child: Scaffold(
          body: dateViewLogic.sharedPreferences
                      .getStringList(dateViewLogic.mKey) ==
                  null
              ? FutureBuilder<bool>(
                  future: dateViewLogic.sharedPreferences
                      .setStringList(dateViewLogic.mKey, []),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      dateViewLogic.list = [];
                      return empty();
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              : dateViewLogic.list.isEmpty
                  ? empty()
                  : ScrollConfiguration(
                      behavior: ScrollBehavior(),
                      child: Builder(
                        builder: (BuildContext ctx) => NestedScrollView(
                          body: ListView.separated(
                            reverse: false,
                            padding: EdgeInsets.only(
                                bottom: screen.convert(60, height),
                                top: 6 /
                                    dateViewLogic.globals.screen.height *
                                    dateViewLogic.globals.screen.height),
                            itemCount: dateViewLogic.list.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Dismissible(
                              key: GlobalKey(debugLabel: index.toString()),
                              onDismissed: (x) {
                                dateViewLogic.showDeleteAlertDialog(
                                    index, context);
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal:
                                        screen.convert(14, screen.width),
                                    vertical: screen.convert(5, height)),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Material(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.red,
                                      child: InkWell(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        highlightColor:
                                            Colors.black.withOpacity(0.1),
                                        onTap: () {
                                          dateViewLogic.showDeleteAlertDialog(
                                              index, context);
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          type: MaterialType.canvas,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                screen.convert(
                                                    8, screen.aspectRatio)),
                                            child: Icon(
                                              Icons.remove,
                                              size: 30 /
                                                  dateViewLogic
                                                      .globals.aspectRatio *
                                                  dateViewLogic
                                                      .globals.aspectRatio,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: dateViewLogic
                                                .globals.screen
                                                .convert(
                                                    6,
                                                    dateViewLogic.globals.screen
                                                        .width))),
                                    Material(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.orange,
                                      child: InkWell(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        highlightColor:
                                            Colors.black.withOpacity(0.1),
                                        onTap: () {
                                          dateViewLogic.showItemDetails(
                                              index, context);
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          type: MaterialType.canvas,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                screen.convert(
                                                    8, screen.aspectRatio)),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 30 /
                                                  dateViewLogic
                                                      .globals.aspectRatio *
                                                  dateViewLogic
                                                      .globals.aspectRatio,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                leading: InkWell(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  highlightColor: Colors.black.withOpacity(0.1),
                                  child: Material(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: Colors.green,
                                    type: MaterialType.canvas,
                                    child: InkWell(
                                      onTap: () async {
                                        dateViewLogic.updateItem(
                                            context: context,
                                            dateViewIndex: index);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(screen.convert(
                                            8, screen.aspectRatio)),
                                        child: Icon(
                                          Icons.mode_edit,
                                          size: 30 /
                                              dateViewLogic
                                                  .globals.aspectRatio *
                                              dateViewLogic.globals.aspectRatio,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  jsonDecode(dateViewLogic.list[index])['Date'],
                                  style: TextStyle(),
                                ),
                              ),
                            ),
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(
                              height: 30 /
                                  dateViewLogic.globals.height *
                                  dateViewLogic.globals.height,
                            ),
                          ),
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) =>
                                  [
                            SliverAppBar(
                              snap: true,
                              floating: true,
                              actions: <Widget>[
                                ButtonTheme(
                                  minWidth: 40,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(0))),
                                    color: Colors.orangeAccent,
                                    child: Icon(
                                      Icons.add,
                                      size: 30 /
                                          dateViewLogic
                                              .globals.screen.aspectRatio *
                                          dateViewLogic
                                              .globals.screen.aspectRatio,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      dateViewLogic.addItem(context);
                                    },
                                  ),
                                )
                              ],
                              centerTitle: true,
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/${dateViewLogic.globals.addOrEditPages[dateViewArgs.index]['icon']}',
                                    color: Colors.white,
                                    width: dateViewLogic.globals.screen.convert(
                                        50, dateViewLogic.globals.width),
                                    height: dateViewLogic.globals.screen
                                        .convert(
                                            30, dateViewLogic.globals.height),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  Text(
                                      dateViewLogic.globals.addOrEditPages[
                                          dateViewLogic.mainViewIndex]['name'],
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
