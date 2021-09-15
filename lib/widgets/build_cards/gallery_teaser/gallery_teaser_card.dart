import 'package:flutter/material.dart';
import 'navigate_gallery_teaser.dart';
import 'package:algarve_wedding/pages/gallery/logic/build_collage.dart';

Widget returnGalleryTeaser(
    List gallery, String galleryName, BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 10),
        child: Container(
          child: Text(
            galleryName,
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
              itemCount: gallery.length,
              itemBuilder: (context, index) {
                if (gallery[index]['visible'].toString() == "true") {
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
                                  GalleryCollage(
                                      galleryName: gallery[index]['name'],
                                      gallery: gallery[index]['imageFolder']),
                                  Container(
                                    color: Color.fromRGBO(0, 0, 0, 0.6),
                                  ),
                                  Center(
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        gallery[index]['name'],
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
                        gallery[index]['name'],
                        gallery[index]['imageFolder'],
                        context,
                        gallery[index]['visible']),
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
