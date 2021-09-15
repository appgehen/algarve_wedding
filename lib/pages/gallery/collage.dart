import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/fallback_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget GalleryCollaged(BuildContext context) {
  return Column(
    children: [
      CachedNetworkImage(
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/marry-me-cf187.appspot.com/o/weddingDayGallery%2Fimage_picker_B57F9402-BBAA-4A4E-B96D-DC18C304F2A8-96748-00002C32000747D9.jpg?alt=media&token=5fc690d6-6506-41d1-a067-93f1ac739cb4",
        fadeInDuration: const Duration(milliseconds: 500),
        fadeInCurve: Curves.easeIn,
        fit: BoxFit.cover,
      ),
    ],
  );
}
