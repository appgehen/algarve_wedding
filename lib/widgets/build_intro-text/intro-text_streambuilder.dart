import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:algarve_wedding/widgets/build_cards/listview_error_case.dart';
import 'intro-text_card.dart';

List introTexts = [];
List introSignin = [];

Widget returnIntroStreamBuilder(List currentList, String streamChild,
    String introFor, BuildContext context) {
  var _firebaseRef = FirebaseDatabase().reference().child(streamChild);

  return Column(
    children: [
      StreamBuilder(
        stream: _firebaseRef.onValue,
        builder: (context, snap) {
          if (snap.hasData &&
              !snap.hasError &&
              snap.data.snapshot.value != null) {
            Map dataMap = snap.data.snapshot.value;
            currentList.clear();
            int position;

            dataMap.forEach((index, data) {
              if (dataMap.containsKey(introFor)) {
                currentList.add({"key": index, ...data});
              }
            });

            for (var i = 0; i < currentList.length; i++) {
              if (currentList[i]['key'] == introFor) {
                position = i;
              }
            }
            return returnIntroText(currentList, introFor, position, context);
          } else {
            return ErrorCase();
          }
        },
      ),
    ],
  );
}
