import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'logic/add_image.dart';
import 'package:algarve_wedding/widgets/fallback_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'slideshow/gallery_slideshow.dart';
import 'package:flutter/cupertino.dart';
import 'logic/session.dart';

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

  List<String> _galleryImages = [];
  List<PhotoViewGalleryPageOptions> _slideShowNew = [];
  List<Widget> _galleryWidgets = [];
  List _imageData = [];
  bool _isloading = true;
  bool _isLoadingNewContent = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _loadImages();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  void _getMoreData() {
    //TODO Content loads a bit bumpy.
    if (_isLoadingNewContent == false) {
      _isLoadingNewContent = true;
      _displayImage(_galleryImages.length, _galleryImages.length + 20);
    }

    setState(() {});
  }

  void _loadImages() async {
    var _firebaseStorage = FirebaseStorage.instance.ref('gallery');

    _clearImageList();
    await _firebaseStorage
        .child(gallery.toString() + '/thumbs')
        .listAll()
        .then((_result) {
      _imageData = _result.items;
      _imageData.removeWhere(
          (element) => element.toString().contains('1500x1500.webp'));
    });

    if (_imageData.length == 0) {
      _showGallery();
    } else {
      if (_imageData.length >= 20) {
        _displayImage(0, 20);
      } else {
        _displayImage(0, _imageData.length);
      }
    }
  }

  void _clearImageList() async {
    //TODO This consumes to much data. I'd like to change it so that I only refresh the data if new images have been added or old ones have been deleted.
    setState(() {
      _galleryImages.clear();
      _slideShowNew.clear();
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

  void _displayImage(int start, int end) async {
    for (var i = start; i < end; i++) {
      print(i);
      print(_imageData[i]);
      final _link = await _imageData[i].getDownloadURL();
      setState(() {
        _galleryImages.add(_link.toString());
        _buildGallery(_galleryImages.length, end);
      });
    }
  }

  void _buildGallery(int _id, int end) {
    int _pictureID = _id - 1;
    _slideShowNew.add(PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(
          _galleryImages[_pictureID].replaceAll("500x500", "1500x1500")),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 1.8,
      initialScale: PhotoViewComputedScale.contained,
    ));
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
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SlideShow(
                    pictureID: _pictureID,
                    slideShowNew: _slideShowNew,
                    galleryName: galleryName,
                    galleryImages: _galleryImages,
                    allPictures: _imageData,
                  ),
                )).then((value) => print(castSession));
          });
        },
      ),
    );
    if (_id == end) {
      setState(() {
        _isloading = false;
        _isLoadingNewContent = false;
      });
    }
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
                : CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            if (index == _galleryWidgets.length) {
                              if (_isLoadingNewContent == true) {
                                return Center(
                                  child: Container(
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }
                            return _galleryWidgets[index];
                          },
                          childCount: _galleryWidgets.length + 1,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
