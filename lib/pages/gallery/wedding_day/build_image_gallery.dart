import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BuildGallery extends StatefulWidget {
  @override
  _BuildGalleryState createState() => _BuildGalleryState();
}

class _BuildGalleryState extends State<BuildGallery> {
  var _firebaseStorage = FirebaseStorage.instance.ref('weddingImages');
  List<Widget> _galleryImages = [];
  bool _isloading = true;
  int _imagesLength;

  @override
  void initState() {
    super.initState();
    _firebaseStorage.listAll().then((result) {
      _imagesLength = result.items.length;
      result.items.forEach((imageRef) {
        _displayImage(imageRef);
      });
    });
  }

  void _displayImage(imageRef) async {
    final _link = await imageRef.getDownloadURL();

    setState(
      () {
        _galleryImages.add(
          Container(
            height: 200,
            width: 200,
            child: Image(
              image: CachedNetworkImageProvider(_link),
              fit: BoxFit.cover,
            ),
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
