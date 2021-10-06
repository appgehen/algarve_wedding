import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/fadein_animation.dart';
import 'package:algarve_wedding/widgets/header_image.dart';
import 'package:algarve_wedding/widgets/build_intro-text/intro-text_streambuilder.dart';
import 'news_buildlist.dart';
import 'news_add/news_add_floatingactionbutton.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isAdmin;
bool isLoading = true;

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  void initState() {
    getAdminMode();
    super.initState();
  }

  void getAdminMode() async {
    final prefs = await SharedPreferences.getInstance();
    final key = prefs.getString("adminMode").toString();
    if (key.toString() == "true") {
      setState(() {
        isAdmin = true;
        isLoading = false;
      });
    } else {
      setState(() {
        isAdmin = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          isLoading ? Center() : showFloatingActionButton(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          getHeaderImage('roadtoportugal.webp', context, false),
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
                                returnIntroStreamBuilder(
                                    introTexts, 'introTexts', 'news', context),
                              ],
                            ),
                          ),
                        ),
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
