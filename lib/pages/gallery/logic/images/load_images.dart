import 'package:firebase_storage/firebase_storage.dart';
import '../session.dart';

void loadImages(String gallery) async {
  var _firebaseStorage = FirebaseStorage.instance.ref('gallery');

  await _firebaseStorage
      .child(gallery.toString() + '/thumbs')
      .listAll()
      .then((_result) {
    rawImageData = _result.items;
    rawImageData.removeWhere(
        (element) => element.toString().contains('1500x1500.webp'));
  });
}
