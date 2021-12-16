import '../session.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:algarve_wedding/widgets/fallback_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import '../../slideshow/gallery_slideshow.dart';

void displayImage(int start, int end, BuildContext context, String galleryName,
    String origin) async {
  if (origin == "gallery" && galleryWidgets.length != slideShowImages.length) {
    for (var i = galleryWidgets.length; i < slideShowImages.length; i++) {
      await _addGalleryWidgets(i, context, galleryName);
    }
  } else if (origin == "gallery" &&
      galleryWidgets.length == slideShowImages.length) {
    for (var i = start; i < end; i++) {
      final _link = await rawImageData[i].getDownloadURL();
      galleryImages.add(_link.toString());
      await _addGalleryWidgets(i, context, galleryName);
      await _buildGallery(i, context, galleryName);
    }
  } else {
    for (var i = start; i < end; i++) {
      final _link = await rawImageData[i].getDownloadURL();
      galleryImages.add(_link.toString());
      await _buildGallery(i, context, galleryName);
    }
  }
}

void _buildGallery(
    int _pictureID, BuildContext context, String galleryName) async {
  slideShowImages.add(PhotoViewGalleryPageOptions(
    imageProvider: NetworkImage(
        galleryImages[_pictureID].replaceAll("500x500", "1500x1500")),
    minScale: PhotoViewComputedScale.contained * 0.8,
    maxScale: PhotoViewComputedScale.covered * 1.8,
    initialScale: PhotoViewComputedScale.contained,
  ));
}

void _addGalleryWidgets(
    int _pictureID, BuildContext context, String galleryName) {
  print(galleryWidgets.length);
  print(slideShowImages.length);
  print(_pictureID);
  galleryWidgets.add(
    GestureDetector(
      child: Container(
          height: 200,
          width: 200,
          decoration: FallbackImage(),
          child: CachedNetworkImage(
            imageUrl: galleryImages[_pictureID],
            fadeInDuration: const Duration(milliseconds: 500),
            fadeInCurve: Curves.easeIn,
            fit: BoxFit.cover,
          )),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SlideShow(
                pictureID: _pictureID,
                galleryName: galleryName,
              ),
            ));
      },
    ),
  );
}
