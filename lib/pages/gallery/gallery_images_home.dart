import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_viewer/image_viewer.dart';
import 'logic/add_image.dart';
import 'package:algarve_wedding/widgets/fallback_image.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:algarve_wedding/logic/return_storage-image.dart';

ReturnStorageImage _returnStorageImage = ReturnStorageImage();

class Gallery extends StatefulWidget {
  final String galleryName;
  final String gallery;
  const Gallery({Key key, this.galleryName, this.gallery}) : super(key: key);

  @override
  _GalleryState createState() =>
      _GalleryState(galleryName: this.galleryName, gallery: this.gallery);
}

class _GalleryState extends State<Gallery> {
  String galleryName;
  String gallery;
  bool download = false;
  bool downloadHint = false;
  _GalleryState({this.galleryName, this.gallery});

  String _message = "";
  String _path = "";
  String _size = "";
  String _mimeType = "";
  File _imageFile;
  int _progress = 0;

  List<String> _galleryImages = [];
  List<String> _slideShow = [];
  int _imagesLength;
  List<Widget> _galleryWidgets = [];
  bool _isloading = true;
  int countImages;
  bool downloadInProgress = false;

  @override
  void initState() {
    _loadImages();
    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progress = progress;
      });
    });
    super.initState();
  }

  void _loadImages() async {
    var _firebaseStorage = FirebaseStorage.instance.ref('gallery');
    await _clearImageList();
    //await Future.delayed(Duration(seconds: 2));
    setState(() {
      _firebaseStorage
          .child(gallery.toString() + '/thumbs')
          .listAll()
          .then((_result) {
        _imagesLength = _result.items.length;
        if (_imagesLength == 0) {
          _showGallery();
        } else {
          _result.items.forEach((imageRef) {
            _displayImage(imageRef);
          });
        }
      });
    });
  }

  void _clearImageList() async {
    setState(() {
      countImages = 0;
      _galleryImages.clear();
      _slideShow.clear();
      _galleryWidgets.clear();
      _isloading = true;
    });
  }

  void _showGallery() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            AddImage(galleryName: galleryName, gallery: gallery)));
    await _loadImages();
  }

  void _displayImage(imageRef) async {
    final _link = await imageRef.getDownloadURL();
    if (_link.toString().contains("500x500.webp")) {
      countImages = countImages + 1;
      _galleryImages.add(_link.toString());
      _buildGallery(_galleryImages.length);
    } else {
      countImages = countImages + 1;
      if (countImages == _imagesLength) {
        setState(() {
          _isloading = false;
        });
      }
    }
  }

  void _buildGallery(int _id) {
    int _pictureID = _id - 1;
    _slideShow
        .add(_galleryImages[_pictureID].replaceAll("500x500", "1500x1500"));
    _galleryWidgets.add(
      GestureDetector(
        child: Container(
            height: 200,
            width: 200,
            decoration: FallbackImage(),
            child: CachedNetworkImage(
              imageUrl: _galleryImages[_pictureID],
              fadeInDuration: const Duration(milliseconds: 500),
              fadeInCurve: Curves.easeIn,
              fit: BoxFit.cover,
            )),
        onTap: () {
          setState(() {
            if (download == false) {
              ImageViewer.showImageSlider(
                images: _slideShow,
                startingPosition: _pictureID,
              );
            } else if (download == true) {
              setState(() {
                downloadInProgress = true;
              });
              _downloadImage(_galleryImages[_pictureID]);
            }
          });
        },
      ),
    );
    if (_id == 10) {
      setState(() {
        _isloading = false;
      });
    } else if (countImages == _imagesLength) {
      setState(() {
        _isloading = false;
      });
    }
  }

  void _downloadImage(String _imageURL) async {
    String _finalUrl = _imageURL
        .replaceAll("%2Fthumbs", "")
        .replaceAll("_500x500", "")
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

  /*void _finalDownload(String _value) async {
    await ImageDownloader.downloadImage(_value);
    setState(() {
      downloadInProgress = false;
    });
    _showSnackbar();
  }*/

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(galleryName.toString()),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (download == false)
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  download = true;
                  downloadHint = true;
                });
              },
              child: Icon(Icons.download),
              backgroundColor: Theme.of(context).accentColor,
            ),
          if (download == false)
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: FloatingActionButton(
                onPressed: () {
                  _showGallery();
                },
                child: Icon(Icons.camera_alt_outlined),
                backgroundColor: Theme.of(context).accentColor,
              ),
            ),
          if (download == true)
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    download = false;
                  });
                },
                child: Icon(Icons.done),
                backgroundColor: Theme.of(context).accentColor,
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Container(
            child: _isloading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).accentColor,
                    ),
                  )
                : Stack(children: [
                    CustomScrollView(
                      slivers: <Widget>[
                        SliverGrid.count(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: _galleryWidgets,
                        ),
                      ],
                    ),
                    if (downloadHint == true)
                      AlertDialog(
                        title: Text(
                          "Bilder herunterladen",
                          style: TextStyle(
                            fontFamily: 'Amatic Regular',
                            height: 1.5,
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                        content: Text(
                          "Tippe einfach auf das Bild, das Du herunterladen möchtest. Sobald Du fertig bist kannst Du den Download Modus über den Button unten rechts wieder beenden.",
                          style: TextStyle(
                            fontSize: 15.0,
                            height: 1.5,
                            color: Colors.white,
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              'Verstanden',
                              style: TextStyle(
                                fontSize: 15.0,
                                height: 1.5,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                downloadHint = false;
                              });
                            },
                          ),
                        ],
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
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
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
                  ]),
          ),
        ),
      ),
    );
  }
}
