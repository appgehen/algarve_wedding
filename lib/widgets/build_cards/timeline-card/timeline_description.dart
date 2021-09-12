import 'package:flutter/material.dart';

Widget returnTimelineDescription(
    List itemList, int index, BuildContext context) {
  if (itemList[index]['description'].toString() != "") {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        itemList[index]['description'].toString(),
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  } else {
    return Container();
  }
}
