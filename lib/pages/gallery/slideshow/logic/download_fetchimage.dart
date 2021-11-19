Future<String> downloadImage(String _imageURL) async {
  String _finalUrl = _imageURL
      .replaceAll("%2Fthumbs", "")
      .replaceAll("_1500x1500", "")
      .replaceAll(".webp", ".jpg")
      .replaceAll(
          "https://firebasestorage.googleapis.com:443/v0/b/marry-me-cf187.appspot.com/o/",
          "")
      .replaceAll(
          "https://firebasestorage.googleapis.com/v0/b/marry-me-cf187.appspot.com/o/",
          "")
      .replaceAll("%2F", "/");

  String _result = _finalUrl.substring(0, _finalUrl.indexOf('?alt=media'));

  return _result;
}
