import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:algarve_wedding/design/custom_icons_icons.dart';
import 'package:algarve_wedding/pages/save_the_date/save_the_date.dart';
import 'package:algarve_wedding/pages/location/location_home/location_home.dart';
import 'package:algarve_wedding/pages/weddingABC/weddingABC_home.dart';
import 'package:algarve_wedding/pages/quiz/quiz_home.dart';
import 'package:algarve_wedding/pages/news/news_home.dart';
import 'package:algarve_wedding/pages/timeline/timeline_home.dart';

//TODO Load data from Backend

List<BottomNavigationBarItem> bottomNavigationItems = [
  BottomNavigationBarItem(
    icon: Icon(CustomIcons.savethedate),
    title: Text('Countdown'),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.notifications_active),
    title: Text('Vorfreude'),
  ),
  BottomNavigationBarItem(
    icon: Icon(CustomIcons.location),
    title: Text('Portugal'),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.live_help),
    title: Text('Quiz'),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.info),
    title: Text('Infos'),
  ),
  /*BottomNavigationBarItem(
    icon: Icon(Icons.photo_library_outlined),
    title: Text('Gallerie'),
  ),*/
];
List<Widget> bottomNavigationChildren = [
  SaveTheDate(),
  News(),
  Algarve(),
  Quiz(),
  Timeline(),
  //WeddingABC(),
  //ImageGalleryNeu(),
];
