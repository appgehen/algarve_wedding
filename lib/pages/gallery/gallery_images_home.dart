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
import 'logic/images/load_images.dart';
import 'logic/images/display_images.dart';

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

  bool _isloading = true;
  bool _isLoadingNewContent = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _setup();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  void _setup() async {
    await _clearImageList();
    await loadImages(gallery);

    if (rawImageData.length == 0) {
      _addImages();
    } else {
      if (rawImageData.length >= 20) {
        await displayImage(0, 20, context, galleryName, "gallery");
        setState(() {
          _isloading = false;
          _isLoadingNewContent = false;
        });
      } else {
        await displayImage(
            0, rawImageData.length, context, galleryName, "gallery");
        setState(() {
          _isloading = false;
          _isLoadingNewContent = false;
        });
      }
    }
  }

  void _getMoreData() async {
    //TODO Content loads a bit bumpy.
    //ensure that the current data from the slideshow are loaded
    setState(() {});
    if (_isLoadingNewContent == false) {
      _isLoadingNewContent = true;
      await displayImage(galleryImages.length, galleryImages.length + 20,
          context, galleryName, "gallery");
      setState(() {
        _isloading = false;
        _isLoadingNewContent = false;
      });
    }
    setState(() {});
  }

  void _clearImageList() async {
    setState(() {
      galleryImages.clear();
      slideShowImages.clear();
      galleryWidgets.clear();
      rawImageData.clear();
      _isloading = true;
    });
  }

  void _addImages() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            AddImage(galleryName: galleryName, gallery: gallery)));
    await _setup();
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
                _addImages();
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
                            if (index == galleryWidgets.length) {
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
                            return galleryWidgets[index];
                          },
                          childCount: galleryWidgets.length + 1,
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
