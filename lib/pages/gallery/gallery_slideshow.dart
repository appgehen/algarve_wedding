import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:algarve_wedding/logic/return_storage-image.dart';

class SlideShow extends StatefulWidget {
  final int pictureID;
  final List<PhotoViewGalleryPageOptions> slideShowNew;
  final String galleryName;
  final List<String> galleryImages;
  const SlideShow(
      {Key key,
      this.pictureID,
      this.slideShowNew,
      this.galleryName,
      this.galleryImages})
      : super(key: key);

  @override
  _SlideShowState createState() => _SlideShowState(
      pictureID: this.pictureID,
      slideShowNew: this.slideShowNew,
      galleryName: this.galleryName,
      galleryImages: this.galleryImages);
}

class _SlideShowState extends State<SlideShow> {
  int pictureID;
  List<PhotoViewGalleryPageOptions> slideShowNew;
  String galleryName;
  List<String> galleryImages;
  _SlideShowState(
      {this.pictureID,
      this.slideShowNew,
      this.galleryName,
      this.galleryImages});

  PageController get _pageController => PageController(initialPage: pictureID);
  ReturnStorageImage _returnStorageImage = ReturnStorageImage();

  bool downloadInProgress = false;
  String _message = "";
  String _path = "";
  String _size = "";
  String _mimeType = "";

  void _downloadImage(String _imageURL) async {
    print("this " + _imageURL);
    setState(() {
      downloadInProgress = true;
    });
    String _finalUrl = _imageURL
        .replaceAll("%2Fthumbs", "")
        .replaceAll("_1500x1500", "")
        .replaceAll(".webp", ".jpg")
        .replaceAll(
            "https://firebasestorage.googleapis.com:443/v0/b/marry-me-cf187.appspot.com/o/",
            "")
        .replaceAll(
            "https://firebasestorage.googleapis.com/v0/b/marry-me-cf187.appspot.com/o/",
            "")
        .replaceAll("%2F", "/");

    String _result = _finalUrl.substring(0, _finalUrl.indexOf('?alt=media'));
    await _returnStorageImage.getImageURL(_result).then((_value) {
      _finalDownload(_value);
    });
  }

  Future<void> _finalDownload(
    String url, {
    AndroidDestinationType destination,
    bool whenError = false,
    String outputMimeType,
  }) async {
    print(url);
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
            setState(() {
              _message = error.toString();
              _path = path ?? '';
            });
          }

          print(error);
        }).timeout(Duration(seconds: 10), onTimeout: () {
          print("timeout");
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
      setState(() {
        _message = error.message ?? '';
      });
      return;
    }

    if (!mounted) return;

    setState(() {
      var location = Platform.isAndroid ? "Directory" : "Photo Library";
      _message = 'Saved as "$fileName" in $location.\n';
      _size = 'size:     $size';
      _mimeType = 'mimeType: $mimeType';
      _path = path ?? '';
      return;
    });

    setState(() {
      downloadInProgress = false;
    });
    _showSnackbar();
  }

  void _showSnackbar() {
    final snackBar = SnackBar(content: const Text('Download erfolgreich'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _onPageViewChange(int page) {
    pictureID = page;
    print("Current Page: " + page.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(galleryName),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              _downloadImage(
                  galleryImages[pictureID].replaceAll("500x500", "1500x1500"));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.black),
            child: PhotoViewGallery(
              pageController: _pageController,
              pageOptions: slideShowNew,
              loadingBuilder: (context, progress) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              onPageChanged: _onPageViewChange,
              backgroundDecoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
          if (downloadInProgress == true)
            Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(
                          'Lade das Bilder herunter...',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        color: Theme.of(context).accentColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
