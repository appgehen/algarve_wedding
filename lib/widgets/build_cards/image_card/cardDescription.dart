import 'package:flutter/material.dart';

Widget cardDescription(List itemList, int index, BuildContext context) {
  if (itemList[index]['imageDescription'] == "") {
    return Container();
  } else {
    return Text(
      itemList[index]['imageDescription'],
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
