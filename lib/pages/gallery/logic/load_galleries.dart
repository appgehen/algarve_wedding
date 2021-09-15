import 'package:firebase_database/firebase_database.dart';

List galleries = [];

void loadBottomNavItems() async {
  var firebaseRef = FirebaseDatabase.instance.reference().child("galleries");
  await firebaseRef.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;
    galleries.clear();
    values.forEach((index, data) => galleries.add({"key": index, ...data}));

    galleries.sort((a, b) => a["sortingOrder"].compareTo(b["sortingOrder"]));
  });
}
