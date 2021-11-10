import 'package:flutter/material.dart';
import 'bottom-navigation_items.dart';
import 'package:algarve_wedding/pages/save_the_date/save_the_date.dart';
import 'package:algarve_wedding/pages/location/location_home/location_home.dart';
import 'package:algarve_wedding/pages/weddingABC/weddingABC_home.dart';
import 'package:algarve_wedding/pages/quiz/quiz_home.dart';
import 'package:algarve_wedding/pages/news/news_home.dart';
import 'package:algarve_wedding/pages/timeline/timeline_home.dart';
import 'package:algarve_wedding/pages/gallery/gallery_overview_home.dart';
import 'package:algarve_wedding/pages/gallery/gallery_slideshow.dart';
import 'bottom-navigation_load_items.dart';
import '../../logic/shared-prefs/save_prefs.dart';

void bottomNavigationBuild(String buildNumber, String version) async {
  bottomNavigationItems.clear();
  bottomNavigationChildren.clear();
  bottomNavItems.forEach((element) {
    if (element["visible"].toString() == "true" &&
        int.parse(buildNumber) >= int.parse(element["buildNumber"])) {
      bottomNavigationItems.add(BottomNavigationBarItem(
        icon: Icon(IconData(int.parse(element['icon']),
            fontFamily: element['fontFamily'].toString())),
        title: Text(element['title'].toString()),
      ));
      if (element["feature"] == "SaveTheDate") {
        bottomNavigationChildren.add(SaveTheDate());
      } else if (element["feature"] == "News") {
        bottomNavigationChildren.add(News());
      } else if (element["feature"] == "Algarve") {
        bottomNavigationChildren.add(Algarve());
      } else if (element["feature"] == "Quiz") {
        bottomNavigationChildren.add(Quiz());
      } else if (element["feature"] == "WeddingABC") {
        bottomNavigationChildren.add(WeddingABC());
      } else if (element["feature"] == "Timeline") {
        bottomNavigationChildren.add(Timeline());
      } else if (element["feature"] == "ImageGalleryNeu") {
        bottomNavigationChildren.add(ImageGalleryNeu());
      }
    } else if (element["visible"].toString() == "false" &&
        element["feature"] == "Quiz") {
      saveSharedPrefs('aPausaVisibility', 'true');
      //TODO change this logic and retreive info from Remote Config
    }
  });
}
