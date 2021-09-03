import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:algarve_wedding/pages/location/portuguese/portuguese_home.dart';
import 'package:algarve_wedding/pages/location/apausa/apausa_home.dart';
import 'package:algarve_wedding/pages/location/discover_algarve/algarve_home.dart';
import '../../../pages/location/location_home/logic/alert_curious.dart';
import '../../../pages/location/location_home/logic/launch_spotify.dart';
import 'package:algarve_wedding/pages/gallery/wedding_day/wedding_gallery.dart';

void openLink(String nextPage, BuildContext context, bool visibility) {
  if (nextPage == 'PortugesePhrases') {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PortugesePhrases(),
        ));
  } else if (nextPage == 'DiscoverAlgarve') {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiscoverAlgarve(),
        ));
  } else if (nextPage == 'APausa' && visibility == true) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => APausa(),
        ));
  } else if (nextPage == 'APausa' && visibility == false) {
    alertCurious(context);
  } else if (nextPage == 'WeddingDay' && visibility == true) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeddingDay(),
        ));
  } else {
    launchSpotify();
  }
}
