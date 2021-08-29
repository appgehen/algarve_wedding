import 'package:firebase_database/firebase_database.dart';

Map<dynamic, dynamic> saveInvitationCodes;

void getInvitationCodes() {
  var db = FirebaseDatabase.instance.reference().child("invitationCodes");
  db.once().then((DataSnapshot snapshot) {
    FirebaseDatabase.instance
        .reference()
        .child("invitationCodes")
        .onValue
        .listen((_event) {
      saveInvitationCodes = snapshot.value;
    });
  });
}
