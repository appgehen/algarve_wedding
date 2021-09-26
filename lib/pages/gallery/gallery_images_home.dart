import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_viewer/image_viewer.dart';
import 'logic/add_image.dart';
import 'package:algarve_wedding/widgets/fallback_image.dart';

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

  List<String> _galleryImages = [];
  List<String> _slideShow = [];
  int _imagesLength;
  List<Widget> _galleryWidgets = [];
  bool _isloading = true;
  int countImages;

  @override
  void initState() {
    _loadImages();
    super.initState();
  }

  void _loadImages() async {
    var _firebaseStorage = FirebaseStorage.instance.ref('gallery');
    await _clearImageList();
    await Future.delayed(Duration(seconds: 2));
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
            ImageViewer.showImageSlider(
              images: _slideShow,
              startingPosition: _pictureID,
            );
          });
        },
      ),
    );
    if (countImages == _imagesLength) {
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
                ? Center(
                    child: CircularProgressIndicator(
                    color: Theme.of(context).accentColor,
                  ))
                : CustomScrollView(
                    slivers: <Widget>[
                      SliverGrid.count(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: _galleryWidgets,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
