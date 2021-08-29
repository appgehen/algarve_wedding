import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/build_cards/listview_streambuilder.dart';

class BuildTimelineList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        returnStreamBuilder(timeline, 'timeline', 'Road to Portugal', context),
      ],
    );
  }
}
