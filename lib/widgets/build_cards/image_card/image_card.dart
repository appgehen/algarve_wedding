import 'package:algarve_wedding/widgets/build_cards/image_card/cardDescription.dart';
import 'package:algarve_wedding/widgets/build_cards/image_card/card_image.dart';
import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/build_cards/listview_streambuilder.dart';
import 'package:algarve_wedding/pages/location/discover_algarve/logic/launch_maps.dart';
import 'card_headline.dart';
import 'card_timestamp.dart';
import 'card_subline.dart';
import 'card_slideshow.dart';

Widget returnImageCard(List itemList, String headline, BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 2),
        child: Container(
          child: Text(
            headline,
            style: Theme.of(context).textTheme.headline2,
          ),
          alignment: Alignment.bottomLeft,
        ),
      ),
      ListView.builder(
        padding: EdgeInsets.only(top: 0, bottom: 20),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Card(
                child: GestureDetector(
                  child: Column(
                    children: [
                      cardImage(itemList, index, context),
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              margin: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              shadowColor: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      flex: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            cardHeadline(
                                                itemList, index, context),
                                            cardDescription(
                                                itemList, index, context),
                                            cardSubline(
                                                itemList, index, context),
                                            cardTimestamp(
                                                itemList, index, context),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    if (itemList == algarveItems) {
                      launchURL(itemList, index);
                    } else {
                      getSlideshow(itemList, index);
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}
