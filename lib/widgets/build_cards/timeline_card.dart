import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget returnTimelineCard(
    List itemList, String headline, BuildContext context) {
  return ListView.builder(
    padding: EdgeInsets.only(top: 10, bottom: 20),
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: itemList.length,
    itemBuilder: (context, index) {
      if (int.parse(itemList[index]['visibleTill']) >
          DateTime.now().millisecondsSinceEpoch) {
        return Column(
          children: [
            showDateDevider(itemList, index, context),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 22, top: 15, bottom: 15),
                    child: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    itemList[index]['headline'],
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      itemList[index]['description'],
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  returnLinkout(itemList, index, context),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5.0, top: 2),
                                          child: Icon(
                                              Icons.calendar_today_rounded,
                                              size: 15.0),
                                        ),
                                        Text(
                                          itemList[index]['timeStamp'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: 2.0,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Stack(
                        children: [
                          Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                              color: Color(int.parse(itemList[index]['color'])),
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          Container(
                            height: 40.0,
                            width: 40.0,
                            child: Icon(
                              IconData(int.parse(itemList[index]['icon']),
                                  fontFamily: itemList[index]['fontFamily']),
                              color: Colors.white,
                              size: 24.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    },
  );
}

Widget returnLinkout(List itemList, int index, BuildContext context) {
  if (itemList[index]['linkout'] != "") {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 15),
      child: Column(
        children: [
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            height: 50,
            minWidth: MediaQuery.of(context).size.width,
            color: Color(int.parse(itemList[index]['color'])),
            textColor: Colors.white,
            child: Text(itemList[index]['linkoutCTA']),
            onPressed: () {
              _launchURL(itemList[index]['linkout']);
            },
          ),
        ],
      ),
    );
  } else {
    return Container();
  }
}

Widget showDateDevider(List itemList, int index, BuildContext context) {
  if (index == 0) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 2, bottom: 20),
      child: Container(
        child: Text(
          itemList[index]['day'],
          style: Theme.of(context).textTheme.headline2,
        ),
        alignment: Alignment.bottomLeft,
      ),
    );
  } else if (itemList[index]['day'] == itemList[index - 1]['day']) {
    if (int.parse(itemList[index - 1]['visibleTill']) <
        DateTime.now().millisecondsSinceEpoch) {
      return Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 2, bottom: 20),
        child: Container(
          child: Text(
            itemList[index]['day'],
            style: Theme.of(context).textTheme.headline2,
          ),
          alignment: Alignment.bottomLeft,
        ),
      );
    } else {
      return Column();
    }
  } else if (itemList[index]['day'] != itemList[index - 1]['day']) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 2, bottom: 20),
      child: Container(
        child: Text(
          itemList[index]['day'],
          style: Theme.of(context).textTheme.headline2,
        ),
        alignment: Alignment.bottomLeft,
      ),
    );
  }
}

_launchURL(String url) async {
  String mapsURL = url;

  if (await canLaunch(mapsURL)) {
    await launch(mapsURL);
  } else {
    throw 'Could not launch $mapsURL';
  }
}
