import 'package:firebase_database/firebase_database.dart';

List quizQuestions = [];

void addQuizQuestions() async {
  var firebaseRef =
      FirebaseDatabase.instance.reference().child("quizquestions");
  firebaseRef.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;
    quizQuestions.clear();
    values.forEach((index, data) => quizQuestions.add({"key": index, ...data}));

    quizQuestions
        .sort((a, b) => a["sortingOrder"].compareTo(b["sortingOrder"]));
  });
}
