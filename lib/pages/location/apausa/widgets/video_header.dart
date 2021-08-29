import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../apausa_home.dart';

Widget returnVideoHeader(BuildContext context) {
  return SliverAppBar(
    expandedHeight: 250.0,
    stretch: true,
    pinned: true,
    stretchTriggerOffset: 150.0,
    flexibleSpace: FlexibleSpaceBar(
      stretchModes: [
        StretchMode.blurBackground,
        StretchMode.zoomBackground,
        StretchMode.fadeTitle,
      ],
      background: Container(
        width: MediaQuery.of(context).size.width,
        height: 250.0,
        child: VideoPlayer(aPausaController),
      ),
    ),
  );
}
