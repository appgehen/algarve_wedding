import 'package:flutter/material.dart';
import 'logic/build_image_gallery.dart';

import 'logic/add_image.dart';

class Gallery extends StatelessWidget {
  final String galleryName;
  final String gallery;
  const Gallery({Key key, this.galleryName, this.gallery}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(galleryName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  AddImage(galleryName: galleryName, gallery: gallery)));
        },
        child: Icon(Icons.camera_alt_outlined),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: BuildGallery(galleryName: galleryName, gallery: gallery),
        ),
      ),
    );
  }
}
