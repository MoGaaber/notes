import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:notes/logic/date_view.dart';
import 'package:notes/models/details_view_args.dart';
import 'package:notes/screens/details_view.dart';
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
//    slideAnimationController.repeat(reverse: true);
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                size: 30 /
                    dateViewLogic.globals.screen.aspectRatio *
                    dateViewLogic.globals.screen.aspectRatio,
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
                'assets/images/${dateViewLogic.globals.addOrEditPages[dateViewLogic.mainViewIndex]['icon']}',
                color: Colors.white,
                width: dateViewLogic.globals.screen
                    .convert(50, dateViewLogic.globals.width),
                height: dateViewLogic.globals.screen
                    .convert(30, dateViewLogic.globals.height),
                fit: BoxFit.fitHeight,
              ),
              Text(
                  dateViewLogic.globals
                      .addOrEditPages[dateViewLogic.mainViewIndex]['name'],
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
                    child: Builder(
                      builder: (BuildContext ctx) => ListView.separated(
                        reverse: false,
                        padding: EdgeInsets.only(
                            top: 1 /
                                dateViewLogic.globals.screen.height *
                                dateViewLogic.globals.screen.height),
                        itemCount: dateViewLogic.list.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Dismissible(
                          key: GlobalKey(debugLabel: index.toString()),
                          onDismissed: (x) {
                            dateViewLogic.deleteItem(
                                index: index, ctx: context);
                          },
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                contentPadding: EdgeInsets.all(
                                  dateViewLogic.globals.screen.convert(
                                      10, dateViewLogic.globals.aspectRatio),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () async {
                                        dateViewLogic.dateViewIndex = index;
                                        dateViewLogic.notifyListeners();
                                        var result = await Navigator.pushNamed(
                                            context,
                                            dateViewLogic
                                                        .globals.addOrEditPages[
                                                    dateViewLogic.mainViewIndex]
                                                ['route']);
                                        if (result != null) {
                                          dateViewLogic.list[index] = result;
                                          dateViewLogic.notifyListeners();
                                        }
                                      },
                                      child: SizedBox(
                                        height: dateViewLogic.globals.screen
                                            .convert(50,
                                                dateViewLogic.globals.height),
                                        width: dateViewLogic.globals.screen
                                            .convert(50,
                                                dateViewLogic.globals.width),
                                        child: Material(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Colors.green,
                                          type: MaterialType.canvas,
                                          child: Icon(
                                            Icons.mode_edit,
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
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: dateViewLogic
                                                .globals.screen
                                                .convert(
                                                    5,
                                                    dateViewLogic.globals.screen
                                                        .width))),
                                    InkWell(
                                      onTap: () async {
                                        dateViewLogic.dateViewIndex = index;
                                        print('!!!');
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
                                        height: dateViewLogic.globals.screen
                                            .convert(50,
                                                dateViewLogic.globals.height),
                                        width: dateViewLogic.globals.screen
                                            .convert(50,
                                                dateViewLogic.globals.width),
                                        child: Material(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Colors.orange,
                                          type: MaterialType.canvas,
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
                                  ],
                                ),
                                leading: InkWell(
                                  onTap: () {
                                    dateViewLogic.deleteItem(
                                        index: index, ctx: context);
                                  },
                                  child: Material(
                                    color: Colors.red,
                                    type: MaterialType.circle,
                                    child: Icon(
                                      Icons.remove,
                                      size: 40 /
                                          dateViewLogic.globals.aspectRatio *
                                          dateViewLogic.globals.aspectRatio,
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
                                      height: 20 /
                                          dateViewLogic.globals.height *
                                          dateViewLogic.globals.height,
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          height: 20 /
                              dateViewLogic.globals.height *
                              dateViewLogic.globals.height,
                        ),
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
