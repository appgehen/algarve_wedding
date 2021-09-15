import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/build_cards/listview_streambuilder.dart';
import 'package:algarve_wedding/pages/gallery/logic/build_collage.dart';

class BuildGalleryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        returnStreamBuilder(galleries, 'galleries', 'Gallerien', context),
      ],
    );
  }
}
