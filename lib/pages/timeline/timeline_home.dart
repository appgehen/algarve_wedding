import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/fadein_animation.dart';
import 'package:algarve_wedding/widgets/header_image.dart';
import 'package:algarve_wedding/widgets/build_intro-text/intro-text_streambuilder.dart';
import 'timeline_buildlist.dart';
import 'package:algarve_wedding/logic/bottom-navigation/bottom-navigation_items.dart';
import 'package:algarve_wedding/design/custom_icons_icons.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          getHeaderImage('timeline.webp', context, false),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                returnIntroStreamBuilder(introTexts,
                                    'introTexts', 'timeline', context),
                              ],
                            ),
                          ),
                        ),
                        BuildTimelineList()
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
