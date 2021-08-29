import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/fadein_animation.dart';
import 'package:algarve_wedding/logic/return_storage-image.dart';
import 'package:algarve_wedding/widgets/header_image.dart';
import '../../../widgets/build_cards/teaser_card/teaser_card.dart';
import 'package:algarve_wedding/widgets/build_intro-text/intro-text_streambuilder.dart';
import 'package:algarve_wedding/logic/shared-prefs/read_prefs.dart';

ReturnStorageImage returnStorageImage = ReturnStorageImage();

class Algarve extends StatefulWidget {
  @override
  _AlgarveState createState() => _AlgarveState();
}

class _AlgarveState extends State<Algarve> {
  bool _aPausaBlurred = true;
  bool _aPausaVisible = false;
  bool isLoading = true;
  String sharedPrefsVisibility;

  checkAPausaVisibility(String _id) async {
    sharedPrefsVisibility = await readSharedPrefs('aPausaVisibility');
    if (sharedPrefsVisibility == "true") {
      _aPausaBlurred = false;
      _aPausaVisible = true;
    } else {
      _aPausaBlurred = true;
      _aPausaVisible = false;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    readSharedPrefs('aPausaVisibility').then((id) => checkAPausaVisibility(id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                getHeaderImage('Algarve.webp', context, false),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      FadeIn(
                        1,
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: returnIntroStreamBuilder(introTexts,
                                      'introTexts', 'location', context),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, left: 2, bottom: 10),
                                child: Container(
                                  child: Text(
                                    'Freu Dich drauf!', //TODO Retreive subheadline from Database
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  alignment: Alignment.bottomLeft,
                                ),
                              ),
                              returnTeaserCard(
                                  'spotify',
                                  'Playlist auf Spotify',
                                  context,
                                  'Spotify',
                                  true),
                              returnTeaserCard(
                                  'discoverAlgarve',
                                  'Algarve entdecken',
                                  context,
                                  'DiscoverAlgarve',
                                  true),
                              returnTeaserCard(
                                  'learnPortugese',
                                  'Portugiesisch lernen',
                                  context,
                                  'PortugesePhrases',
                                  true),
                              Visibility(
                                visible: _aPausaVisible,
                                maintainState: true,
                                child: returnTeaserCard(
                                    'aPausa',
                                    'Unsere Unterkunft',
                                    context,
                                    'APausa',
                                    true),
                              ),
                              Visibility(
                                visible: _aPausaBlurred,
                                maintainState: true,
                                child: returnTeaserCard(
                                    'aPausa_blurred',
                                    'Unsere Unterkunft',
                                    context,
                                    'APausa',
                                    _aPausaVisible),
                              ),
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
