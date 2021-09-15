import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/fadein_animation.dart';
import 'package:algarve_wedding/widgets/header_image.dart';
import 'package:algarve_wedding/widgets/build_intro-text/intro-text_streambuilder.dart';
import 'gallery_buildlist.dart';

class ImageGalleryNeu extends StatefulWidget {
  @override
  _ImageGalleryNeuState createState() => _ImageGalleryNeuState();
}

class _ImageGalleryNeuState extends State<ImageGalleryNeu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          getHeaderImage('gallery-weddingday.webp', context, true),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                FadeIn(
                  1,
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: returnIntroStreamBuilder(
                                introTexts, 'introTexts', 'gallery', context),
                          ),
                        ),
                        BuildGalleryList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
