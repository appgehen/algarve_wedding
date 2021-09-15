import 'package:flutter/material.dart';
import 'package:algarve_wedding/logic/return_storage-image.dart';
import 'package:algarve_wedding/widgets/fallback_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'navigate_gallery_teaser.dart';

ReturnStorageImage _returnStorageImage = ReturnStorageImage();

Widget returnGalleryTeaser(
    List itemList, String headline, BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 10),
        child: Container(
          child: Text(
            headline,
            style: Theme.of(context).textTheme.headline2,
          ),
          alignment: Alignment.bottomLeft,
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 0, bottom: 20),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                if (itemList[index]['visible'].toString() == "true") {
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Card(
                        child: Stack(
                          children: [
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.width) / 16 * 9,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  FutureBuilder(
                                    future: _returnStorageImage.getImageURL(
                                        'headerImages/gallery-weddingday.webp'),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {
                                      return Container(
                                        decoration: FallbackImage(),
                                        child: CachedNetworkImage(
                                          imageUrl: (snapshot.data).toString(),
                                          fadeInDuration:
                                              const Duration(milliseconds: 500),
                                          fadeInCurve: Curves.easeIn,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                  Container(
                                    color: Color.fromRGBO(0, 0, 0, 0.6),
                                  ),
                                  Center(
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        itemList[index]['name'],
                                        style: TextStyle(
                                          fontFamily: 'Amatic Regular',
                                          height: 1.5,
                                          fontSize: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () => openGallery(
                        itemList[index]['name'],
                        itemList[index]['imageFolder'],
                        context,
                        itemList[index]['visible']),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      )
    ],
  );
}
