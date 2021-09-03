import 'package:flutter/material.dart';
import 'logic/build_image_gallery.dart';

import 'logic/add_image.dart';

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
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddImage()));
        },
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
