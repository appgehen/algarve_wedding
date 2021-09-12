import 'package:flutter/material.dart';
import 'timeline_date_devider.dart';
import 'timeline_cta_linkout.dart';
import 'timeline_description.dart';
import 'timeline_timestamp.dart';
import 'timeline_headline.dart';
import 'timeline_vertical_line.dart';
import 'timeline_icon.dart';

Widget returnTimelineCard(
    List itemList, String headline, BuildContext context) {
  return ListView.builder(
    padding: EdgeInsets.only(top: 10, bottom: 20),
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: itemList.length,
    itemBuilder: (context, index) {
      if (itemList[index]['visibleTill'] != "") {
        if (int.parse(itemList[index]['visibleTill']) >
            DateTime.now().millisecondsSinceEpoch) {
          return Column(
            children: [
              returnTimelineDateDevider(itemList, index, context),
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
                                    returnTimelineHeadline(
                                        itemList, index, context),
                                    returnTimelineDescription(
                                        itemList, index, context),
                                    returnTimelineLinkout(
                                        itemList, index, context),
                                    returnTimelineTimeStamp(
                                        itemList, index, context),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    returnTimelineVerticalLine(itemList, index, context),
                    returnTimelineIcon(itemList, index, context)
                  ],
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      } else {
        return Container();
      }
    },
  );
}
