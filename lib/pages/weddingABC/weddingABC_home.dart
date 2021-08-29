import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/build_cards/listview_streambuilder.dart';
import 'package:algarve_wedding/widgets/fadein_animation.dart';
import 'package:algarve_wedding/widgets/header_image.dart';

class WeddingABC extends StatefulWidget {
  @override
  _WeddingABCState createState() => _WeddingABCState();
}

class _WeddingABCState extends State<WeddingABC> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        getHeaderImage('weddingABC.webp', context, false),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              FadeIn(
                1,
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
                  child: returnStreamBuilder(weddingABC, 'weddingABC',
                      'Alles, was ihr wissen müsst', context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
