import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:algarve_wedding/logic/return_storage-image.dart';
import 'package:algarve_wedding/widgets/fallback_image.dart';

ReturnStorageImage _returnStorageImage = ReturnStorageImage();

class GalleryCollage extends StatefulWidget {
  final String galleryName;
  final String gallery;
  const GalleryCollage({Key key, this.galleryName, this.gallery})
      : super(key: key);
  @override
  _GalleryCollageState createState() => _GalleryCollageState(
      galleryName: this.galleryName, gallery: this.gallery);
}

class _GalleryCollageState extends State<GalleryCollage> {
  String galleryName;
  String gallery;
  _GalleryCollageState({this.galleryName, this.gallery});

  bool _isloading = true;
  List<String> _galleryImages = [];

  @override
  void initState() {
    loadGallery();
    super.initState();
  }

  void loadGallery() async {
    _galleryImages.clear();
    var _firebaseStorage = FirebaseStorage.instance.ref('gallery');
    await _firebaseStorage.child(gallery.toString()).listAll().then((result) {
      int _image = result.items.length;
      result.items.forEach((imageRef) {
        _displayImage(imageRef, _image);
      });
    });
  }

  void _displayImage(imageRef, int _image) async {
    final _link = await imageRef.getDownloadURL();
    String _firebaseURL =
        "https://firebasestorage.googleapis.com:443/v0/b/marry-me-cf187.appspot.com";
    String _imagekitURL = "https://ik.imagekit.io/p9mcy4diyxi";
    String _url = _link.replaceAll(_firebaseURL, _imagekitURL);
    _galleryImages.add(_url + "&tr=n-gallery_thumbnail");
    if (_galleryImages.length == _image) {
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_galleryImages.length == 1) {
      return _isloading
          ? CircularProgressIndicator()
          : Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 16 * 9,
                  child: CachedNetworkImage(
                    imageUrl: _galleryImages[0].toString(),
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeInCurve: Curves.easeIn,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 16 * 9,
                  ),
                ),
              ],
            );
    } else if (_galleryImages.length == 2) {
      return _isloading
          ? CircularProgressIndicator()
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 16 * 9,
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: _galleryImages[0].toString(),
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeInCurve: Curves.easeIn,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height:
                        (MediaQuery.of(context).size.width / 16 * 4.5) - 1.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2.0,
                    color: Colors.white,
                  ),
                  CachedNetworkImage(
                    imageUrl: _galleryImages[1].toString(),
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeInCurve: Curves.easeIn,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height:
                        (MediaQuery.of(context).size.width / 16 * 4.5) - 1.0,
                  )
                ],
              ),
            );
    } else if (_galleryImages.length == 3) {
      return _isloading
          ? CircularProgressIndicator()
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 16 * 9,
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: _galleryImages[0].toString(),
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeInCurve: Curves.easeIn,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 16 * 4.5,
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width) - 20,
                    height: 2.0,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: _galleryImages[1].toString(),
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height:
                              (MediaQuery.of(context).size.width / 16 * 4.5) -
                                  2,
                        ),
                      ),
                      Container(
                        width: 2.0,
                        height:
                            (MediaQuery.of(context).size.width / 16 * 4.5) - 2,
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: _galleryImages[2].toString(),
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height:
                              (MediaQuery.of(context).size.width / 16 * 4.5) -
                                  2,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
    } else if (_galleryImages.length == 4) {
      return _isloading
          ? CircularProgressIndicator()
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 16 * 9,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: _galleryImages[0].toString(),
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 16 * 4.5,
                        ),
                      ),
                      Container(
                        width: 2.0,
                        height: MediaQuery.of(context).size.width / 16 * 4.5,
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: _galleryImages[1].toString(),
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 16 * 4.5,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2.0,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: _galleryImages[2].toString(),
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height:
                              (MediaQuery.of(context).size.width / 16 * 4.5) -
                                  2,
                        ),
                      ),
                      Container(
                        width: 2.0,
                        height:
                            (MediaQuery.of(context).size.width / 16 * 4.5) - 2,
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: _galleryImages[3].toString(),
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height:
                              (MediaQuery.of(context).size.width / 16 * 4.5) -
                                  2,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
    } else if (_galleryImages.length >= 5) {
      return _isloading
          ? CircularProgressIndicator()
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 16 * 9,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: _galleryImages[0].toString(),
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 16 * 4.5,
                        ),
                      ),
                      Container(
                        width: 2.0,
                        height: MediaQuery.of(context).size.width / 16 * 4.5,
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: _galleryImages[1].toString(),
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 16 * 4.5,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2.0,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: _galleryImages[2].toString(),
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height:
                              (MediaQuery.of(context).size.width / 16 * 4.5) -
                                  2,
                        ),
                      ),
                      Container(
                        width: 2.0,
                        height:
                            (MediaQuery.of(context).size.width / 16 * 4.5) - 2,
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: _galleryImages[3].toString(),
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height:
                              (MediaQuery.of(context).size.width / 16 * 4.5) -
                                  2,
                        ),
                      ),
                      Container(
                        width: 2.0,
                        height:
                            (MediaQuery.of(context).size.width / 16 * 4.5) - 2,
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: _galleryImages[4].toString(),
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height:
                              (MediaQuery.of(context).size.width / 16 * 4.5) -
                                  2,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
    } else {
      return FutureBuilder(
        future:
            _returnStorageImage.getImageURL('headerImages/gallery-empty.png'),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Container(
            decoration: FallbackImage(),
            child: CachedNetworkImage(
              imageUrl: (snapshot.data).toString(),
              fadeInDuration: const Duration(milliseconds: 500),
              fadeInCurve: Curves.easeIn,
              fit: BoxFit.cover,
            ),
          );
        },
      );
    }
  }
}
