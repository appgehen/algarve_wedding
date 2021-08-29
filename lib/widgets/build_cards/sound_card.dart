import 'package:flutter/material.dart';
import 'package:algarve_wedding/pages/location/portuguese/logic/play_audio.dart';

Widget returnSoundCard(List itemList, String headline, BuildContext context) {
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
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start, //change here don't //worked
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        itemList[index]['germanText'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
                                    ),
                                    Text(
                                      itemList[index]['portugeseTranslation'],
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              flex: 2,
                              child: Icon(
                                Icons.play_arrow,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () => playAudio(itemList, index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ],
  );
}
