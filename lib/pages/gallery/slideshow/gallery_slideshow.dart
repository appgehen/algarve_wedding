import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:algarve_wedding/logic/return_storage-image.dart';
import 'widgets/success_snackbar.dart';
import 'widgets/download_status.dart';
import 'logic/download_fetchimage.dart';
import 'logic/download_image.dart';
import 'package:cast/cast.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view.dart';
import '../logic/session.dart';
import '../logic/images/display_images.dart';

class SlideShow extends StatefulWidget {
  final int pictureID;
  final String galleryName;
  const SlideShow({
    Key key,
    this.pictureID,
    this.galleryName,
  }) : super(key: key);

  @override
  SlideShowState createState() => SlideShowState(
        pictureID: this.pictureID,
        galleryName: this.galleryName,
      );
}

class SlideShowState extends State<SlideShow> {
  int pictureID;
  String galleryName;
  SlideShowState({
    this.pictureID,
    this.galleryName,
  });

  PageController get _pageController => PageController(initialPage: pictureID);
  ReturnStorageImage _returnStorageImage = ReturnStorageImage();

  String _imageCast;
  Future<List<CastDevice>> _future;
  CastDevice _connectedDevice;

  bool downloadInProgress = false;

  @override
  void initState() {
    super.initState();
    _imageCast = galleryImages[pictureID].replaceAll("500x500", "1500x1500");
    if (castSession == null) {
      _startSearch();
    } else if (castSession.state != null &&
        castSession.state == CastSessionState.connected) {
      _onPageViewChange(pictureID);
    } else if (castSession.state == CastSessionState.closed) {
      _startSearch();
    }
  }

  void _endSession() async {
    castSession.close();
    _startSearch();
  }

  void _startSearch() {
    _future = CastDiscoveryService().search();
  }

  void _setDownloadState(bool _downloadState) {
    setState(() {
      downloadInProgress = _downloadState;
    });
  }

  void _downloadImage(String _imageURL) async {
    _setDownloadState(true);
    await downloadImage(_imageURL).then((value) {
      _returnStorageImage.getImageURL(value).then((_value) {
        finalDownload(_value).then((value) {
          _setDownloadState(false);
          showSnackbar(context);
        });
      });
    });
  }

  _onPageViewChange(int page) async {
    //TODO If first picture in SlideShow is last one I have to load one additional picture
    pictureID = page;
    await displayImage(
        galleryImages.length, galleryImages.length + 2, context, galleryName);
    setState(() {
      _imageCast = galleryImages[pictureID].replaceAll("500x500", "1500x1500");
    });
    _sendMessageShowPhoto(castSession);
  }

  Future<void> _connectAndPlayMedia(
      BuildContext context, CastDevice object) async {
    final session = await CastSessionManager().startSession(object);

    var index = 0;

    session.messageStream.listen((message) {
      index += 1;
      print('receive message: $message');

      if (index == 2) {
        castSession = session;
        Future.delayed(Duration(seconds: 5)).then((x) {
          _sendMessageShowPhoto(castSession);
        });
      }
    });

    session.sendMessage(CastSession.kNamespaceReceiver, {
      'type': 'LAUNCH',
      'appId': 'CC1AD845', // set the appId of your app here
    });
  }

  void _sendMessageShowPhoto(CastSession session) {
    var message = {
      // Here you can plug an URL to any mp4, webm, mp3 or jpg file with the proper contentType.
      'contentId': _imageCast,
      'contentType': 'image/jpg',
      'streamType': 'LIVE', // or LIVE

      // Title and cover displayed while buffering
      /*'metadata': {
        'type': 0,
        'metadataType': 0,
        'title': "Big Buck Bunny",
        'images': [
          {
            'url':
                'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg'
          }
        ]
      }*/
    };

    session.sendMessage(CastSession.kNamespaceMedia, {
      'type': 'LOAD',
      'autoPlay': true,
      'currentTime': 0,
      'media': message,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(galleryName),
        actions: <Widget>[
          if (castSession != null && castSession.state != null)
            if (castSession.state == CastSessionState.connected)
              IconButton(
                icon: const Icon(
                  Icons.cast_connected,
                  color: Colors.white,
                ),
                onPressed: () {
                  _endSession();
                },
              ),
          if (castSession != null &&
              castSession.state != null &&
              castSession.state == CastSessionState.closed)
            FutureBuilder<List<CastDevice>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                } else if (snapshot.data.isNotEmpty) {
                  return IconButton(
                    icon: const Icon(Icons.cast),
                    onPressed: () {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Gerät wählen',
                              style: TextStyle(
                                fontFamily: 'Amatic Regular',
                                height: 1.5,
                                fontSize: 35,
                                color: Colors.white,
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Column(
                                    children: snapshot.data.map((device) {
                                      return ListTile(
                                        tileColor:
                                            Theme.of(context).accentColor,
                                        title: Text(
                                          device.name,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            height: 1.5,
                                            fontFamily: 'Roboto Light',
                                            color: Colors.white,
                                          ),
                                        ),
                                        onTap: () {
                                          print(device);
                                          _connectedDevice = device;
                                          _connectAndPlayMedia(context, device)
                                              .then((value) {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                      );
                                    }).toList(),
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Abbrechen'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          if (castSession == null)
            FutureBuilder<List<CastDevice>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                } else if (snapshot.data.isNotEmpty) {
                  return IconButton(
                    icon: const Icon(Icons.cast),
                    onPressed: () {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Gerät wählen',
                              style: TextStyle(
                                fontFamily: 'Amatic Regular',
                                height: 1.5,
                                fontSize: 35,
                                color: Colors.white,
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Column(
                                    children: snapshot.data.map((device) {
                                      return ListTile(
                                        tileColor:
                                            Theme.of(context).accentColor,
                                        title: Text(
                                          device.name,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            height: 1.5,
                                            fontFamily: 'Roboto Light',
                                            color: Colors.white,
                                          ),
                                        ),
                                        onTap: () {
                                          print(device);
                                          _connectedDevice = device;
                                          _connectAndPlayMedia(context, device)
                                              .then((value) {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                      );
                                    }).toList(),
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Abbrechen'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
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
              pageOptions: slideShowImages,
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
          if (downloadInProgress == true) downloadStatus(context),
        ],
      ),
    );
  }
}
