import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/fallback_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:algarve_wedding/logic/return_storage-image.dart';

ReturnStorageImage _returnStorageImage = ReturnStorageImage();

Widget cardImage(List itemList, int index, BuildContext context) {
  return FutureBuilder(
    future: _returnStorageImage.getImageURL(itemList[index]['imagePath']),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      if (itemList[index]['imagePath'] == "") {
        return Container();
      } else {
        return Container(
          decoration: FallbackImage(),
          width: MediaQuery.of(context).size.width,
          height: (MediaQuery.of(context).size.width - 60) / 16 * 9,
          child: Stack(alignment: Alignment.bottomLeft, children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
            ),
            Container(
              child: CachedNetworkImage(
                imageUrl: (snapshot.data).toString(),
                fadeInDuration: const Duration(milliseconds: 500),
                fadeInCurve: Curves.easeIn,
                fit: BoxFit.cover,
              ),
              width: MediaQuery.of(context).size.width,
            ),
          ]),
        );
      }
    },
  );
}
