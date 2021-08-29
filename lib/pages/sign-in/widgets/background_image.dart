import 'package:flutter/material.dart';
import 'package:algarve_wedding/logic/return_storage-image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:algarve_wedding/widgets/fallback_image.dart';

ReturnStorageImage _returnStorageImage = ReturnStorageImage();

Widget returnBackgroundImage(BuildContext context) {
  return FutureBuilder(
    future: _returnStorageImage.getImageURL('signinScreen/sign-in.webp'),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      return Container(
        decoration: FallbackImage(),
        child: CachedNetworkImage(
          imageUrl: (snapshot.data).toString(),
          fadeInDuration: const Duration(milliseconds: 500),
          fadeInCurve: Curves.easeIn,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      );
    },
  );
}
