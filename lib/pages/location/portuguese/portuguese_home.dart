import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/fadein_animation.dart';
import 'package:algarve_wedding/widgets/header_image.dart';
import 'logic/build_list.dart';
import 'package:algarve_wedding/widgets/build_intro-text/intro-text_streambuilder.dart';

class PortugesePhrases extends StatefulWidget {
  @override
  _PortugesePhrasesState createState() => _PortugesePhrasesState();
}

class _PortugesePhrasesState extends State<PortugesePhrases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          getHeaderImage('learnPortugese.webp', context, true),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                FadeIn(
                  1,
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
                    child: Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: returnIntroStreamBuilder(introTexts,
                                'introTexts', 'learnPortugese', context),
                          ),
                        ),
                        BuildSoundList(),
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
