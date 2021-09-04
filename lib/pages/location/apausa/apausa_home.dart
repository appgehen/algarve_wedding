import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/fadein_animation.dart';
import 'logic/build_rooms.dart';
import 'logic/build_route.dart';
import 'package:video_player/video_player.dart';
import 'package:algarve_wedding/widgets/build_intro-text/intro-text_streambuilder.dart';
import 'widgets/video_header.dart';

VideoPlayerController aPausaController;

class APausa extends StatefulWidget {
  @override
  _APausaState createState() => _APausaState();
}

class _APausaState extends State<APausa> {
  @override
  void initState() {
    super.initState();
    aPausaController = VideoPlayerController.asset('assets/apausa.mp4');
    aPausaController.setLooping(true);
    aPausaController.initialize().then((_) => setState(() {}));
    Future.delayed(const Duration(milliseconds: 1000), () {
      aPausaController.play();
    });
  }

  @override
  void dispose() {
    aPausaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          returnVideoHeader(context),
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
                                introTexts, 'introTexts', 'apausa', context),
                          ),
                        ),
                        BuildRoute(),
                        BuildImageList(),
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
