import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/build_cards/listview_streambuilder.dart';

class BuildSoundList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        returnStreamBuilder(
            learnPortugese,
            'learnPortugese',
            'Portugiesisch lernen',
            context), //TODO Retreive subheadline from Database
      ],
    );
  }
}
