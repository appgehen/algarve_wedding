import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget returnIntroText(
    List itemList, String introFor, int position, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          itemList[position][introFor + '-headline'],
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          itemList[position][introFor + '-text'],
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    ],
  );
}
