import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:algarve_wedding/pages/gallery/gallery_images_home.dart';

void openGallery(String imageHeadline, String gallery, BuildContext context,
    bool visibility) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            Gallery(galleryName: imageHeadline, gallery: gallery),
      ));
}
