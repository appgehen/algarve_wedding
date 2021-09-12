import 'package:flutter/material.dart';

returnTimelineIcon(List itemList, int index, BuildContext context) {
  if (itemList[index]['icon'].toString() != "" &&
      itemList[index]['color'].toString() != "" &&
      itemList[index]['fontFamily'].toString() != "") {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Stack(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                color: Color(int.parse(itemList[index]['color'])),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            Container(
              height: 40.0,
              width: 40.0,
              child: Icon(
                IconData(int.parse(itemList[index]['icon']),
                    fontFamily: itemList[index]['fontFamily'].toString()),
                color: Colors.white,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  } else {
    return Container();
  }
}
