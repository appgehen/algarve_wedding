import 'package:flutter/material.dart';

Widget returnTimelineDateDevider(
    List itemList, int index, BuildContext context) {
  if (itemList[index]['day'].toString() != "" &&
      itemList[index]['visibleTill'].toString() != "") {
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 2, bottom: 20),
        child: Container(
          child: Text(
            itemList[index]['day'].toString(),
            style: Theme.of(context).textTheme.headline2,
          ),
          alignment: Alignment.bottomLeft,
        ),
      );
    } else if (itemList[index]['day'].toString() ==
        itemList[index - 1]['day'].toString()) {
      if (int.parse(itemList[index - 1]['visibleTill']) <
          DateTime.now().millisecondsSinceEpoch) {
        return Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 2, bottom: 20),
          child: Container(
            child: Text(
              itemList[index]['day'].toString(),
              style: Theme.of(context).textTheme.headline2,
            ),
            alignment: Alignment.bottomLeft,
          ),
        );
      } else {
        return Column();
      }
    } else if (itemList[index]['day'].toString() !=
        itemList[index - 1]['day'].toString()) {
      return Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 2, bottom: 20),
        child: Container(
          child: Text(
            itemList[index]['day'].toString(),
            style: Theme.of(context).textTheme.headline2,
          ),
          alignment: Alignment.bottomLeft,
        ),
      );
    }
  } else {
    return Container();
  }
}
