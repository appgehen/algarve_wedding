import 'package:flutter/material.dart';
import 'build_image_gallery.dart';

class WeddingDay extends StatefulWidget {
  @override
  _WeddingDayState createState() => _WeddingDayState();
}

class _WeddingDayState extends State<WeddingDay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hochzeitstag"),
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed: handleUploadType,
        child: Icon(Icons.camera_alt_outlined),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: BuildGallery(),
        ),
      ),
    );
  }
}
