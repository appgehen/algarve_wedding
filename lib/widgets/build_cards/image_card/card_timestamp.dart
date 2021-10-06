import 'package:flutter/material.dart';

Widget cardTimestamp(List itemList, int index, BuildContext context) {
  if (itemList[index]['timeStamp'] == "") {
    return Container();
  } else {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          itemList[index]['timeStamp'],
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
