import 'package:flutter/material.dart';
import 'package:algarve_wedding/logic/return_storage-image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:algarve_wedding/widgets/fallback_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

ReturnStorageImage _returnStorageImage = ReturnStorageImage();

Widget returnHeaderImage(BuildContext context) {
  String imagePath;
  if (FirebaseAuth.instance.currentUser != null) {
    imagePath = 'headerImages';
  } else {
    imagePath = 'signinScreen';
  }

  return FutureBuilder(
    future: _returnStorageImage.getImageURL('$imagePath/contact.webp'),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      return Center(
        child: ClipOval(
          child: Container(
            decoration: FallbackImage(),
            child: CachedNetworkImage(
              imageUrl: (snapshot.data).toString(),
              fadeInDuration: const Duration(milliseconds: 500),
              fadeInCurve: Curves.easeIn,
              fit: BoxFit.cover,
              width: 180,
              height: 180,
            ),
          ),
        ),
      );
    },
  );
}
