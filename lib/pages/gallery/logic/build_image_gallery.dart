import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_viewer/image_viewer.dart';
import 'add_image.dart';

class BuildGallery extends StatefulWidget {
  final String galleryName;
  final String gallery;
  const BuildGallery({Key key, this.galleryName, this.gallery})
      : super(key: key);
  @override
  _BuildGalleryState createState() =>
      _BuildGalleryState(galleryName: this.galleryName, gallery: this.gallery);
}

class _BuildGalleryState extends State<BuildGallery> {
  String galleryName;
  String gallery;
  _BuildGalleryState({this.galleryName, this.gallery});
  List<Widget> _galleryImages = [];
  List<String> _slideShow = [];
  bool _isloading = true;
  int _imagesLength;

  @override
  void initState() {
    var _firebaseStorage = FirebaseStorage.instance.ref(gallery.toString());
    super.initState();
    _firebaseStorage.listAll().then((result) {
      _imagesLength = result.items.length;
      if (_imagesLength == 0) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                AddImage(galleryName: galleryName, gallery: gallery)));
      } else {
        result.items.forEach((imageRef) {
          _displayImage(imageRef);
        });
      }
    });
  }

  void _displayImage(imageRef) async {
    final _link = await imageRef.getDownloadURL();
    setState(
      () {
        _slideShow.add(_link);
        _galleryImages.add(
          GestureDetector(
            child: Container(
              height: 200,
              width: 200,
              child: Image(
                image: CachedNetworkImageProvider(_link),
                fit: BoxFit.cover,
              ),
            ),
            onTap: () {
              setState(() {
                ImageViewer.showImageSlider(
                  images: _slideShow,
                  startingPosition: 0,
                  //TODO the position doesn't work
                );
              });
            },
          ),
        );
      },
    );
    if (_galleryImages.length == _imagesLength) {
      setState(() {
        _isloading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: _isloading
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: <Widget>[
                SliverGrid.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: _galleryImages,
                ),
              ],
            ),
    );
  }
}
