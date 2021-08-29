import 'package:flutter/material.dart';
import 'package:algarve_wedding/logic/theme-mode/controller.dart';

BoxDecoration FallbackImage() {
  if (lightModeActive == true) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/fallback_large.jpg'),
        fit: BoxFit.cover,
      ),
    );
  } else {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/fallback_large_dark.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }
}
