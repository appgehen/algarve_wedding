import 'package:flutter/material.dart';
import 'timeline_launch_url.dart';
import 'timeline_get_color.dart';

Widget returnTimelineLinkout(List itemList, int index, BuildContext context) {
  if (itemList[index]['linkout'].toString() != "" &&
      itemList[index]['linkoutCTA'].toString() != "" &&
      itemList[index]['colorDark'].toString() != "" &&
      itemList[index]['colorLight'].toString() != "") {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 15),
      child: Column(
        children: [
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            height: 50,
            minWidth: MediaQuery.of(context).size.width,
            color: getColor(itemList, index, context),
            textColor: Colors.white,
            child: Text(itemList[index]['linkoutCTA'].toString()),
            onPressed: () {
              timeLineLaunchURL(itemList[index]['linkout'].toString());
            },
          ),
        ],
      ),
    );
  } else {
    return Container();
  }
}
