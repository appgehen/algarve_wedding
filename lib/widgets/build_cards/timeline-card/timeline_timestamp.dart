import 'package:flutter/material.dart';

Widget returnTimelineTimeStamp(List itemList, int index, BuildContext context) {
  if (itemList[index]['timeStamp'].toString() != "") {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0, top: 2),
            child: Icon(Icons.calendar_today_rounded, size: 15.0),
          ),
          Text(
            itemList[index]['timeStamp'].toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  } else {
    return Container();
  }
}
