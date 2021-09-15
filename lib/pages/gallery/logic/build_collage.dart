import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:algarve_wedding/widgets/fallback_image.dart';

List<String> _galleryImages = [];

class GalleryCollage extends StatefulWidget {
  @override
  _GalleryCollageState createState() => _GalleryCollageState();
}

class _GalleryCollageState extends State<GalleryCollage> {
  bool _isloading = true;

  @override
  void initState() {
    loadGallery();
    super.initState();
  }

  void loadGallery() async {
    _galleryImages.clear();
    var _firebaseStorage = FirebaseStorage.instance.ref("weddingDayGallery");
    await _firebaseStorage.listAll().then((result) {
      int _image = result.items.length;
      result.items.forEach((imageRef) {
        _displayImage(imageRef, _image);
      });
    });
  }

  void _displayImage(imageRef, int _image) async {
    final _link = await imageRef.getDownloadURL();
    _galleryImages.add(_link);
    print(_galleryImages.length);
    print(_image);
    if (_galleryImages.length == _image - 1) {
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
                  child: CachedNetworkImage(
                    imageUrl: _galleryImages[0].toString(),
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeInCurve: Curves.easeIn,
                    fit: BoxFit.cover,
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            );
    }
    if (_galleryImages.length == 2) {
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
                  CachedNetworkImage(
                    imageUrl: _galleryImages[1].toString(),
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeInCurve: Curves.easeIn,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 16 * 4.5,
                  )
                ],
              ),
            );
    }
    if (_galleryImages.length == 3) {
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
                          height: MediaQuery.of(context).size.width / 16 * 4.5,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: _galleryImages[2].toString(),
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 16 * 4.5,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
    }
    if (_galleryImages.length == 4) {
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
                          height: MediaQuery.of(context).size.width / 16 * 4.5,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: _galleryImages[3].toString(),
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 16 * 4.5,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
    } else {
      return Container();
    }
  }
}
