import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/fadein_animation.dart';
import 'countdown.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() => runApp(SaveTheDate());

class SaveTheDate extends StatefulWidget {
  @override
  _SaveTheDateState createState() => _SaveTheDateState();
}

class _SaveTheDateState extends State<SaveTheDate> {
  var _firebaseStorage = FirebaseStorage.instance.ref('savethedateImages');
  int _imagesLength;
  bool _isloading = true;

  final List<String> imgList = [];

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
    setState(() {
      imgList.add(_link);
    });
    if (imgList.length == _imagesLength) {
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).accentColor,
            ))
          : Stack(
              children: [
                Builder(
                  builder: (context) {
                    final double height = MediaQuery.of(context).size.height;
                    return CarouselSlider(
                      options: CarouselOptions(
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 1000),
                        autoPlayCurve: Curves.linear,
                        initialPage: 0,
                        height: height,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                      ),
                      items: imgList
                          .map(
                            (item) => Container(
                              width: MediaQuery.of(context).size.width,
                              child: CachedNetworkImage(
                                imageUrl: item,
                                fadeInDuration:
                                    const Duration(milliseconds: 500),
                                fadeInCurve: Curves.easeIn,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
                Stack(
                  children: [
                    Container(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                    FadeIn(
                      1.0,
                      Column(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width -
                                      (MediaQuery.of(context).size.width / 4),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      'Alicia & Daniel',
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: SizedBox(
                                    width: 120.0,
                                    child: Divider(
                                      color: Colors.white,
                                      thickness: 1.5,
                                      indent: 10,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.favorite,
                                  size: 18.0,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Icon(
                                    Icons.favorite,
                                    size: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.favorite,
                                  size: 18.0,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                    width: 120.0,
                                    child: Divider(
                                      color: Colors.white,
                                      thickness: 1.5,
                                      endIndent: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width -
                                      (MediaQuery.of(context).size.width / 4),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: ShowCountdownTimer(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
