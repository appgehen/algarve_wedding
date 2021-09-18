import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_viewer/image_viewer.dart';
import 'logic/add_image.dart';

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
  _GalleryState({this.galleryName, this.gallery});

  List<String> _slideShow = [];
  int _imagesLength;
  List<Widget> _galleryImages = [];
  bool _isloading = true;

  @override
  void initState() {
    var _firebaseStorage = FirebaseStorage.instance.ref('gallery');
    super.initState();
    _firebaseStorage.child(gallery.toString()).listAll().then((_result) {
      _imagesLength = _result.items.length;
      if (_imagesLength == 0) {
        _showGallery();
      } else {
        _result.items.forEach((imageRef) {
          _displayImage(imageRef);
        });
      }
    });
  }

  void _showGallery() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            AddImage(galleryName: galleryName, gallery: gallery)));
    await _loadImages();
  }

  void _loadImages() async {
    var _firebaseStorage = FirebaseStorage.instance.ref('gallery');
    await _clearImageList();
    setState(() {
      _firebaseStorage.child(gallery.toString()).listAll().then((_result) {
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
      _slideShow.clear();
      _galleryImages.clear();
      _isloading = true;
    });
  }

  void _displayImage(imageRef) async {
    final _link = await imageRef.getDownloadURL();
    String _firebaseURL =
        "https://firebasestorage.googleapis.com/v0/b/marry-me-cf187.appspot.com";
    String _imagekitURL = "https://ik.imagekit.io/p9mcy4diyxi";
    String _url = _link.replaceAll(_firebaseURL, _imagekitURL);
    setState(
      () {
        _slideShow.add(_url + "&tr=n-gallery_original_optimized");
        _galleryImages.add(
          GestureDetector(
            child: Container(
              height: 200,
              width: 200,
              child: Image(
                image: CachedNetworkImageProvider(
                    _url + "&tr=n-gallery_thumbnail"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(galleryName.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showGallery();
        },
        child: Icon(Icons.camera_alt_outlined),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Container(
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
          ),
        ),
      ),
    );
  }
}
