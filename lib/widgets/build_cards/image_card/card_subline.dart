import 'package:flutter/material.dart';

Widget cardSubline(List itemList, int index, BuildContext context) {
  if (itemList[index]['subline'] == "") {
    return Container();
  } else {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          itemList[index]['subline'],
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
