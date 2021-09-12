import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:algarve_wedding/widgets/build_cards/listview_error_case.dart';
import 'package:algarve_wedding/widgets/build_cards/abc_card.dart';
import 'package:algarve_wedding/widgets/build_cards/image_card.dart';
import 'package:algarve_wedding/widgets/build_cards/sound_card.dart';
import 'package:algarve_wedding/widgets/build_cards/timeline-card/timeline_card.dart';

List weddingABC = [];
List algarveItems = [];
List apausaItems = [];
List roadToPortugal = [];
List learnPortugese = [];
List timeline = [];

Widget returnStreamBuilder(List currentList, String streamChild,
    String headline, BuildContext context) {
  var _firebaseRef = FirebaseDatabase().reference().child(streamChild);

  return Column(
    children: [
      StreamBuilder(
        stream: _firebaseRef.onValue,
        builder: (context, snap) {
          if (snap.hasData &&
              !snap.hasError &&
              snap.data.snapshot.value != null) {
            Map data = snap.data.snapshot.value;
            currentList.clear();

            data.forEach(
                (index, data) => currentList.add({"key": index, ...data}));

            currentList.sort((a, b) {
              return a["sortingOrder"].compareTo(b["sortingOrder"]);
            });
            if (streamChild == 'weddingABC') {
              return returnABCCard(currentList, headline, context);
            } else if (streamChild == 'discoverAlgarve') {
              return returnImageCard(currentList, headline, context);
            } else if (streamChild == 'locationAssets') {
              return returnImageCard(currentList, headline, context);
            } else if (streamChild == 'learnPortugese') {
              return returnSoundCard(currentList, headline, context);
            } else if (streamChild == 'timeline') {
              return returnTimelineCard(currentList, headline, context);
            } else {
              return returnImageCard(currentList, headline, context);
            }
          } else {
            return ErrorCase();
          }
        },
      ),
    ],
  );
}
