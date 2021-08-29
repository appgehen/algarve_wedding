import 'package:flutter/material.dart';

Widget returnABCCard(List itemList, String headline, BuildContext context) {
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
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              constraints: new BoxConstraints(
                                minWidth: 40.0,
                              ),
                              child: Center(
                                child: Text(
                                  itemList[index]['letter'],
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 10,
                            child: Text(
                              itemList[index]['description'],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )
    ],
  );
}
