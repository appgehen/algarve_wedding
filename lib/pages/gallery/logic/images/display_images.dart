import '../session.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:algarve_wedding/widgets/fallback_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import '../../slideshow/gallery_slideshow.dart';

void displayImage(
    int start, int end, BuildContext context, String galleryName) async {
  for (var i = start; i < end; i++) {
    final _link = await rawImageData[i].getDownloadURL();
    galleryImages.insertAll(i, [_link.toString()]);
    await _buildGallery(galleryImages.length, end, context, galleryName);
  }
}

void _buildGallery(
    int _id, int end, BuildContext context, String galleryName) async {
  int _pictureID = _id - 1;
  slideShowImages.insertAll(_pictureID, [
    PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(
          galleryImages[_pictureID].replaceAll("500x500", "1500x1500")),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 1.8,
      initialScale: PhotoViewComputedScale.contained,
    )
  ]);
  galleryWidgets.insertAll(_pictureID, [
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
  ]);
}
