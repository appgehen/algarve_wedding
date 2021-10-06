import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:algarve_wedding/widgets/build_cards/listview_error_case.dart';
import 'package:algarve_wedding/widgets/build_cards/abc_card.dart';
import 'package:algarve_wedding/widgets/build_cards/image_card/image_card.dart';
import 'package:algarve_wedding/widgets/build_cards/sound_card.dart';
import 'package:algarve_wedding/widgets/build_cards/timeline-card/timeline_card.dart';
import 'package:algarve_wedding/widgets/build_cards/gallery_teaser/gallery_teaser_card.dart';

List weddingABC = [];
List algarveItems = [];
List apausaItems = [];
List roadToPortugal = [];
List learnPortugese = [];
List timeline = [];
List galleries = [];

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

            print(streamChild);
            if (streamChild == 'weddingABC') {
              currentList.sort((a, b) {
                return a["sortingOrder"].compareTo(b["sortingOrder"]);
              });
              return returnABCCard(currentList, headline, context);
            } else if (streamChild == 'discoverAlgarve') {
              currentList.sort((a, b) {
                return a["sortingOrder"].compareTo(b["sortingOrder"]);
              });
              return returnImageCard(currentList, headline, context);
            } else if (streamChild == 'locationAssets') {
              currentList.sort((a, b) {
                return a["sortingOrder"].compareTo(b["sortingOrder"]);
              });
              return returnImageCard(currentList, headline, context);
            } else if (streamChild == 'learnPortugese') {
              currentList.sort((a, b) {
                return a["sortingOrder"].compareTo(b["sortingOrder"]);
              });
              return returnSoundCard(currentList, headline, context);
            } else if (streamChild == 'timeline') {
              currentList.sort((a, b) {
                return a["sortingOrder"].compareTo(b["sortingOrder"]);
              });
              return returnTimelineCard(currentList, headline, context);
            } else if (streamChild == 'galleries') {
              currentList.sort((a, b) {
                return a["sortingOrder"].compareTo(b["sortingOrder"]);
              });
              return returnGalleryTeaser(currentList, headline, context);
            } else if (streamChild == 'roadToPortugal') {
              currentList.sort((a, b) {
                return b["sortingOrder"].compareTo(a["sortingOrder"]);
              });
              return returnImageCard(currentList, headline, context);
            } else {
              currentList.sort((a, b) {
                return a["sortingOrder"].compareTo(b["sortingOrder"]);
              });
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
