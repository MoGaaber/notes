import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launch_review/launch_review.dart';
import 'package:notes/logic/globals.dart';
import 'package:notes/logic/main_view.dart';
import 'package:notes/utility/screen.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainView extends StatelessWidget {
  static const route = '/mainView';

  @override
  Widget build(BuildContext context) {
    SharedPreferences sharedPreferences =
        Provider.of<SharedPreferences>(context, listen: true);
    MainViewLogic mainViewLogic =
        Provider.of<MainViewLogic>(context, listen: false);
    Globals globals = Provider.of<Globals>(context, listen: false);
    globals.screen = Screen(
        size: MediaQuery.of(context).size,
        textScale: MediaQuery.textScaleFactorOf(context));
    globals.height = globals.screen.height;
    globals.width = globals.screen.width;
    globals.aspectRatio = globals.screen.aspectRatio;
    globals.textScaleFactor = globals.screen.textScale;

    return SafeArea(
      child: Scaffold(
        //
        drawer: Drawer(
          child: Material(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox.fromSize(
                  size: Size.fromHeight(
                      globals.screen.convert(250, globals.height)),
                  child: DrawerHeader(
                    child: Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/fff.png',
                          fit: BoxFit.contain,
                          width: globals.screen.convert(130, globals.width),
                          color: Colors.orange,
                        ),
                    )),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: globals.screen.convert(10,globals.width)),
                  onTap: () {
                    Share.share(
                        'شارك تطبيقانا مع اصدقائك لتعم الفائده  https://play.google.com/store/apps/details?id=com.HNY.qurancareem',
                        subject: 'Look what I made!');
                  },
                  leading: Icon(FontAwesomeIcons.share),
                  title: Text(
                    'Share App',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    LaunchReview.launch(
                        androidAppId:
                            "https://play.google.com/store/apps/details?id=com.HNY.qurancareem");
                  },
                  leading: Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 28,
                  ),
                  title: Text(
                    'Rate Us',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Home',
          ),
          backgroundColor: Colors.orange,
        ),
        body: sharedPreferences == null
            // instance not ready
            ? Center(
                child: CircularProgressIndicator(),
              )
            // instance is ready
            : ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: ListView.separated(
                  itemCount: globals.addOrEditPages.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.all(10 /
                            globals.screen.aspectRatio *
                            globals.screen.aspectRatio),
                        leading: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            SizedBox(
                                height: 80,
                                width: 50,
                                child: Material(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.orange.withOpacity(0.8),
                                )),
                            Image.asset(
                              'assets/images/${globals.addOrEditPages[index]['icon']}',
                              width: 35 /
                                  globals.screen.width *
                                  globals.screen.width,
                              color: Colors.white,
                              height: 35 /
                                  globals.screen.height *
                                  globals.screen.height,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20 /
                              globals.screen.aspectRatio *
                              globals.screen.aspectRatio,
                          color: Colors.orange,
                        ),
                        onTap: () async {
                          mainViewLogic.navigateToDateView(context, index);
                          if (index == 0 ||
                              index == globals.addOrEditPages.length - 1) {
                            globals.showFullScreenAd();
                          }
                        },
                        title: Text(
                          globals.addOrEditPages[index]['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20 /
                                  globals.screen.textScale *
                                  globals.screen.textScale),
                        ),
                      ),
                    ],
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                ),
              ),
      ),
    );
  }
}

String getAppId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544~1458002511';
  } else if (Platform.isAndroid) {
    //هنا كود  تطبيقك للاعلان
    return 'ca-app-pub-3940256099942544~3347511713';
  }
  return null;
}

String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/2934735716';
  } else if (Platform.isAndroid) {
    // هنا للبانر
    return 'ca-app-pub-3940256099942544/6300978111';
  }
  return null;
}

String getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/4411468910';
  } else if (Platform.isAndroid) {
    //هنا للشاشه الكامله
    return 'ca-app-pub-3940256099942544/1033173712';
  }
  return null;
}
