import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
        drawer: SizedBox.fromSize(
          size: Size.fromWidth(globals.screen.convert(300, globals.width)),
          child: Drawer(
            child: Material(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox.fromSize(
                    size: Size.fromHeight(
                        globals.screen.convert(250, globals.height)),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color: Colors.orange,
                        ),
                        Center(
                            child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                          width: 200,
                          height: 200,
                        )),
                        Container(
                          color: Colors.black.withOpacity(0.9),
                        ),
                        Center(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'C A R   N O T E',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
/*
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Note about your car :)',
                                style: GoogleFonts.adamina(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                            ),
*/
                          ],
                        )),
                      ],
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: globals.screen.convert(20, globals.width),
                    ),
                    onTap: () {
                      Share.share(
                          'شارك تطبيقانا مع اصدقائك لتعم الفائده  https://play.google.com/store/apps/details?id=com.HNY.qurancareem',
                          subject: 'Look what I made!');
                    },
                    leading: Icon(FontAwesomeIcons.share,
                        size: globals.screen.convert(28, globals.aspectRatio)),
                    title: Text(
                      'Share App',
                      style: TextStyle(
                        fontSize:
                            globals.screen.convert(20, globals.aspectRatio),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: globals.screen.convert(20, globals.width)),
                    onTap: () {
                      LaunchReview.launch(
                          androidAppId:
                              "https://play.google.com/store/apps/details?id=com.HNY.qurancareem");
                    },
                    leading: Icon(Icons.star,
                        color: Colors.orange,
                        size: globals.screen.convert(33, globals.aspectRatio)),
                    title: Text(
                      'Rate Us',
                      style: TextStyle(
                        fontSize:
                            globals.screen.convert(20, globals.aspectRatio),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
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
                child: CircularProgressIndicator(
                  backgroundColor: Colors.orange,
                ),
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
                                height:
                                    globals.screen.convert(80, globals.height),
                                width:
                                    globals.screen.convert(50, globals.width),
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
                                  globals.screen.aspectRatio *
                                  globals.screen.aspectRatio),
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
