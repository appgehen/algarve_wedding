import 'package:flutter/material.dart';

returnTimelineVerticalLine(List itemList, int index, BuildContext context) {
  return Positioned(
    left: 20,
    child: Container(
      height: MediaQuery.of(context).size.height,
      width: 2.0,
      color: Colors.grey.shade400,
    ),
  );
}
