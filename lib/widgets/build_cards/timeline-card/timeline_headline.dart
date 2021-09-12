import 'package:flutter/material.dart';

returnTimelineHeadline(List itemList, int index, BuildContext context) {
  if (itemList[index]['headline'].toString() != "") {
    return Text(
      itemList[index]['headline'].toString(),
      style: Theme.of(context).textTheme.headline2,
    );
  } else {
    return Container();
  }
}
