import 'package:firebase_database/firebase_database.dart';

List bottomNavItems = [];

void loadBottomNavItems() async {
  var firebaseRef = FirebaseDatabase.instance.reference().child("bottomNav");
  await firebaseRef.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;
    bottomNavItems.clear();
    values
        .forEach((index, data) => bottomNavItems.add({"key": index, ...data}));

    bottomNavItems
        .sort((a, b) => a["sortingOrder"].compareTo(b["sortingOrder"]));
  });
}
