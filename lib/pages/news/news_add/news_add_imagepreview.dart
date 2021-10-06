import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/fallback_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:algarve_wedding/logic/return_storage-image.dart';

ReturnStorageImage _returnStorageImage = ReturnStorageImage();

Widget cardImage(BuildContext context) {
  return Container(
    decoration: FallbackImage(),
    width: MediaQuery.of(context).size.width,
    height: (MediaQuery.of(context).size.width) / 16 * 9,
  );
}
