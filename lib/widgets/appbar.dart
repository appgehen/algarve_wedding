import 'package:flutter/material.dart';
import 'package:algarve_wedding/pages/contact/contact_home.dart';
import 'package:algarve_wedding/logic/theme-mode/toggle_theme.dart';
import 'package:algarve_wedding/logic/theme-mode/controller.dart';

AppBar returnAppBar(bool SignInPage, BuildContext context) {
  return AppBar(
    title: Image.asset(
      'images/signature_2x.webp',
      height: 30,
    ),
    actions: <Widget>[
      returnAppBarButtons(SignInPage, context),
    ],
  );
}

Icon returnDarkModeSwitchIcon() {
  if (lightModeActive == true) {
    return Icon(Icons.brightness_2_outlined);
  } else {
    return Icon(Icons.wb_sunny);
  }
}

Widget returnAppBarButtons(bool SignInPage, BuildContext context) {
  if (SignInPage == false) {
    return Row(
      children: [
        IconButton(
          icon: returnDarkModeSwitchIcon(),
          onPressed: () {
            toggleThemeMode('Brightness.toggle', context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Contact(),
              ),
            );
          },
        ),
      ],
    );
  } else {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Contact(),
              ),
            );
          },
        ),
      ],
    );
  }
}
