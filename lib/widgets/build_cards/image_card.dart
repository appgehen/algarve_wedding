import 'package:flutter/material.dart';
import 'package:algarve_wedding/logic/return_storage-image.dart';
import 'package:algarve_wedding/widgets/fallback_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:algarve_wedding/widgets/build_cards/listview_streambuilder.dart';
import 'package:algarve_wedding/pages/location/discover_algarve/logic/launch_maps.dart';
import 'package:image_viewer/image_viewer.dart';

ReturnStorageImage _returnStorageImage = ReturnStorageImage();

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
                      FutureBuilder(
                        future: _returnStorageImage
                            .getImageURL(itemList[index]['imagePath']),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          return Container(
                            decoration: FallbackImage(),
                            width: MediaQuery.of(context).size.width,
                            height: (MediaQuery.of(context).size.width - 60) /
                                16 *
                                9,
                            child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                  ),
                                  Container(
                                    child: CachedNetworkImage(
                                      imageUrl: (snapshot.data).toString(),
                                      fadeInDuration:
                                          const Duration(milliseconds: 500),
                                      fadeInCurve: Curves.easeIn,
                                      fit: BoxFit.cover,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ]),
                          );
                        },
                      ),
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5.0),
                                              child: Text(
                                                itemList[index]
                                                    ['imageHeadline'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                            ),
                                            Text(
                                              itemList[index]
                                                  ['imageDescription'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            returnSubline(
                                                itemList, index, context),
                                            returnTimestamp(
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
                      print("slideshow");
                      _getSlideshow(itemList, index);
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

Widget returnTimestamp(List itemList, int index, BuildContext context) {
  if (itemList[index]['timeStamp'] != "") {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          itemList[index]['timeStamp'],
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.right,
        ),
      ),
    );
  } else {
    return Container();
  }
}

Widget returnSubline(List itemList, int index, BuildContext context) {
  if (itemList[index]['subline'] != "") {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          itemList[index]['subline'],
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  } else {
    return Container();
  }
}

Future<String> _getSlideshow(List itemList, int index) async {
  List<String> _timelineSlideshow = [];
  String _imageURL =
      await _returnStorageImage.getImageURL(itemList[index]['imagePath']);
  _timelineSlideshow.add(_imageURL);

  ImageViewer.showImageSlider(
    images: _timelineSlideshow,
    startingPosition: itemList[index]['sortingOrder'],
  );
  return _imageURL;
}
