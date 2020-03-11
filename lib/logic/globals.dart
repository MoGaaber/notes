import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/screens/add_or_edit/amortisseur.dart';
import 'package:notes/screens/add_or_edit/batterie.dart';
import 'package:notes/screens/add_or_edit/courroie.dart';
import 'package:notes/screens/add_or_edit/frenage.dart';
import 'package:notes/screens/add_or_edit/vidangee.dart';
import 'package:notes/utility/screen.dart';
import 'package:notes/widgets/text_field.dart';

class Globals {
  Screen screen;
  double height, width, aspectRatio, textScaleFactor;
  List<Map<String, dynamic>> addOrEditPages;
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

  void initializeAddOrEditPages() {
    addOrEditPages = [
      {
        'textFields': [
          {'type': TextFieldType.number, 'label': 'KM / Miles'},
          {'type': TextFieldType.number, 'label': 'Next Oil Change'},
          {'type': TextFieldType.text, 'label': 'Note'},
        ],
        'controllersLength': 7,
        'yesNoLength': 4,
        'route': Vidangee.route,
        'refKey': SharedPrefKeys.vidangePref,
        'icon': 'oil.png',
        'name': 'VIDANGE',
      },
      {
        'textFields': [
          {'type': TextFieldType.number, 'label': 'KM'},
          {'type': TextFieldType.number, 'label': 'Next KM'},
          {'type': TextFieldType.text, 'label': 'Note'}
        ],
        'controllersLength': 3,
        'yesNoLength': 0,
        'route': Courroie.route,
        'icon': 'motor.png',
        'refKey': SharedPrefKeys.courroiePref,
        'name': 'COURROIE'
      },
      {
        'textFields': [
          {'type': TextFieldType.number, 'label': 'KM'},
          {'type': TextFieldType.text, 'label': 'Note'}
        ],
        'controllersLength': 2,
        'yesNoLength': 2,
        'route': Armortisseur.route,
        'icon': 'damper.png',
        'refKey': SharedPrefKeys.amortisseurPref,
        'name': 'ARMORTISSEUR'
      },
      {
        'textFields': [
          {'type': TextFieldType.number, 'label': 'KM'},
          {'type': TextFieldType.text, 'label': 'Note'}
        ],
        'controllersLength': 2,
        'yesNoLength': 0,
        'route': Batterie.route,
        'icon': 'battery.png',
        'refKey': SharedPrefKeys.batteriPref,
        'name': 'BATTERIE'
      },
      {
        'controllersLength': 2,
        'yesNoLength': 4,
        'route': Freinage.route,
        'icon': 'brake.png',
        'refKey': SharedPrefKeys.freinagePref,
        'name': 'FREINAGE'
      },
    ];
  }

  InterstitialAd admobInterstitial;
  BannerAd bannerAd;
  Globals(BuildContext context) {
    initializeAddOrEditPages();
    admobInterstitial = InterstitialAd(
      adUnitId: getInterstitialAdUnitId(),
    );
    bannerAd = BannerAd(adUnitId: getBannerAdUnitId(), size: AdSize.banner);

    bannerAd..load();
    bannerAd..show();
  }

  void showFullScreenAd() {

    admobInterstitial.dispose();
    admobInterstitial = null;
    admobInterstitial = InterstitialAd(
      adUnitId: getInterstitialAdUnitId(),
    );

    admobInterstitial..load();

    admobInterstitial..show();
  }
}
