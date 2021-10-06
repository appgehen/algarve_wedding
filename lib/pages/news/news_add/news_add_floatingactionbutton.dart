import 'package:flutter/material.dart';
import 'package:algarve_wedding/logic/shared-prefs/read_prefs.dart';
import 'news_add.dart';
import 'package:algarve_wedding/pages/news/news_home.dart';

Widget showFloatingActionButton(BuildContext context) {
  if (isAdmin == true) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNews(),
            ));
      },
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).accentColor,
    );
  } else {
    return Container();
  }
}
