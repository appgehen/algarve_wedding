import 'package:flutter/material.dart';
import 'package:algarve_wedding/logic/theme-mode/get_setTheme.dart';

Color getColor(List itemList, int index, BuildContext context) {
  getThemeMode();
  if (darkMode == true) {
    return Color(int.parse(itemList[index]['colorDark']));
  } else {
    return Color(int.parse(itemList[index]['colorLight']));
  }
}
