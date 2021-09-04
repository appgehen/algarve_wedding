import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_database/firebase_database.dart';

Widget bestOfResultList(
    BuildContext context, String _resultList, String _month) {
  var _quizResultListBestOf = FirebaseDatabase().reference().child(_resultList);
  return StreamBuilder(
    stream: _quizResultListBestOf.onValue,
    builder: (context, snap) {
      if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {
        Map data = snap.data.snapshot.value;
        List item = [];
        List<TableRow> _resultListKeeper = [];

        data.forEach((index, data) => item.add({"key": index, ...data}));
        item.sort((a, b) {
          return a["position"].compareTo(b["position"]);
        });

        if (item != null) {
          _resultListKeeper.add(
            TableRow(
              children: [
                TableCell(child: Container()),
                TableCell(
                  child: Center(
                      child: Text(
                    'Versuche',
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                ),
                TableCell(
                  child: Center(
                    child: Text('Richtige Antworten',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text('Benötigte Zeit',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ),
              ],
            ),
          );
          for (var i = 0; i < item.length; i++) {
            print(item[i]['position'].toString());
            _resultListKeeper.add(
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Text(
                          item[i]['position'].toString() +
                              '. ' +
                              item[i]['playerName'],
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Center(
                          child: Text(item[i]['attempts'].toString(),
                              style: Theme.of(context).textTheme.bodyText1)),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Center(
                          child: Text(item[i]['correctAnswers'].toString(),
                              style: Theme.of(context).textTheme.bodyText1)),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Center(
                          child: Text(item[i]['timeKeeper'].toString() + ' Sek',
                              style: Theme.of(context).textTheme.bodyText1)),
                    ),
                  ),
                ],
              ),
            );
          }
        }

        print(_resultListKeeper.length);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Card(
                        child: ExpandablePanel(
                          //iconColor: Theme.of(context).primaryColor, TODO color
                          header: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    _month,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          expanded: Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, right: 10, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Table(
                                  border: TableBorder.all(
                                      color: Colors.black26,
                                      width: 1,
                                      style: BorderStyle.none),
                                  children: _resultListKeeper,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      } else
        return Text('');
    },
  );
}
