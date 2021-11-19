import 'package:image_downloader/image_downloader.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';

Future<void> finalDownload(String url,
    {AndroidDestinationType destination,
    bool whenError = false,
    String outputMimeType,
    BuildContext context}) async {
  String fileName;
  String path;
  int size;
  String mimeType;
  try {
    String imageId;

    if (whenError) {
      imageId = await ImageDownloader.downloadImage(url,
              outputMimeType: outputMimeType)
          .catchError((error) {
        if (error is PlatformException) {
          String path = "";
          if (error.code == "404") {
            print("Not Found Error.");
          } else if (error.code == "unsupported_file") {
            print("UnSupported FIle Error.");
            path = error.details["unsupported_file_path"];
          }
          /*setState(() {
              _message = error.toString();
              _path = path ?? '';
            });*/
        }
      }).timeout(Duration(seconds: 10), onTimeout: () {
        return;
      });
    } else {
      if (destination == null) {
        imageId = await ImageDownloader.downloadImage(
          url,
          outputMimeType: outputMimeType,
        );
      } else {
        imageId = await ImageDownloader.downloadImage(
          url,
          destination: destination,
          outputMimeType: outputMimeType,
        );
      }
    }

    if (imageId == null) {
      return;
    }
    fileName = await ImageDownloader.findName(imageId);
    path = await ImageDownloader.findPath(imageId);
    size = await ImageDownloader.findByteSize(imageId);
    mimeType = await ImageDownloader.findMimeType(imageId);
  } on PlatformException catch (error) {
    return;
  }

  //if (!mounted) return;
}
