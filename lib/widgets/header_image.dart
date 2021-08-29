import 'package:flutter/material.dart';
import 'package:algarve_wedding/logic/return_storage-image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'fallback_image.dart';

ReturnStorageImage _returnStorageImage = ReturnStorageImage();
//TODO Optimize loading behaviour. The flickering is anoying

Widget getHeaderImage(String headerImage, BuildContext context, bool pinned) {
  print('getHeaderImage');
  return SliverAppBar(
    backgroundColor: Theme.of(context).appBarTheme.color,
    expandedHeight: 250.0,
    stretch: true,
    pinned: pinned,
    stretchTriggerOffset: 150.0,
    flexibleSpace: FlexibleSpaceBar(
      stretchModes: [
        StretchMode.blurBackground,
        StretchMode.zoomBackground,
        StretchMode.fadeTitle,
      ],
      background: Container(
        child: StreamBuilder(
          stream: _returnStorageImage
              .getImageURL('headerImages/$headerImage')
              .asStream(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            print((snapshot.data).toString());
            return Container(
              decoration: FallbackImage(),
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: (snapshot.data).toString(),
                fadeInDuration: const Duration(milliseconds: 500),
                fadeInCurve: Curves.easeIn,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    ),
  );
}
