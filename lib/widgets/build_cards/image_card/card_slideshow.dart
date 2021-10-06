import 'package:flutter/material.dart';
import 'package:algarve_wedding/logic/return_storage-image.dart';
import 'package:image_viewer/image_viewer.dart';

ReturnStorageImage _returnStorageImage = ReturnStorageImage();

Future<String> getSlideshow(List itemList, int index) async {
  List<String> _timelineSlideshow = [];
  String _imageURL =
      await _returnStorageImage.getImageURL(itemList[index]['imagePath']);
  _timelineSlideshow.add(_imageURL);

  ImageViewer.showImageSlider(
    images: _timelineSlideshow,
    startingPosition: itemList[index]['sortingOrder'],
  );
  return _imageURL;
}
