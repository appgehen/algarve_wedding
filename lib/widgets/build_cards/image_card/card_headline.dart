import 'package:flutter/material.dart';

Widget cardHeadline(List itemList, int index, BuildContext context) {
  if (itemList[index]['imageHeadline'] == "") {
    return Container();
  } else {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        itemList[index]['imageHeadline'],
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
