import 'package:firebase_storage/firebase_storage.dart';

class ReturnStorageImage {
  Future<String> getImageURL(String path) async {
    var _firebaseStorage = FirebaseStorage.instance.ref().child(path);
    final url = await Uri.parse(await _firebaseStorage.getDownloadURL());
    return url.toString();
  }
}
