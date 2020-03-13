import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/ads_ids.dart';
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

  InterstitialAd interstitialAd;
  BannerAd bannerAd;
  Globals(BuildContext context) {
    initializeAddOrEditPages();
    FirebaseAdMob.instance.initialize(appId: AdsIds.appId).then((x){
      bannerAd = BannerAd(adUnitId: AdsIds.bannerId, size: AdSize.banner);
      bannerAd..load();
      bannerAd..show();
      interstitialAd = createInterstitialAd()..load();


    });

  }
  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: AdsIds.interId,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.opened ||
            event == MobileAdEvent.failedToLoad) {
          interstitialAd?.dispose();
          interstitialAd = createInterstitialAd();
          interstitialAd.load();
        }
        print(event);
      },
    );
  }

  void showFullScreenAd() {
    interstitialAd?.show();
  }
}
