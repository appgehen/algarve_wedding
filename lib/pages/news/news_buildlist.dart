import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/build_cards/listview_streambuilder.dart';

class BuildImageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        returnStreamBuilder(
            roadToPortugal, 'roadToPortugal', 'Road to Portugal', context),
      ],
    );
  }
}
