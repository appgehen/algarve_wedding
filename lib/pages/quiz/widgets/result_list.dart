import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:algarve_wedding/pages/quiz/quiz_logic.dart';

class BuildResultList extends StatefulWidget {
  @override
  _BuildResultListState createState() => _BuildResultListState();
}

class _BuildResultListState extends State<BuildResultList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: resultListRef.onValue,
      builder: (context, snap) {
        if (snap.hasData &&
            !snap.hasError &&
            snap.data.snapshot.value != null) {
          Map data = snap.data.snapshot.value;
          List item = [];
          data.forEach((index, data) => item.add({"key": index, ...data}));
          item.sort((a, b) {
            if (b["correctAnswers"] == a["correctAnswers"]) {
              return int.tryParse(a["timeKeeper"])
                  .compareTo(int.tryParse(b["timeKeeper"]));
            } else if (b["correctAnswers"] == a["correctAnswers"] &&
                b["timeKeeper"] == a["timeKeeper"]) {
              return a["timeStamp"]
                  .compareTo(b["timeStamp"]); //TODO This doesn't work
            } else {
              return int.tryParse(b["correctAnswers"])
                  .compareTo(int.tryParse(a["correctAnswers"]));
            }
          });

          return Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 30),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                        child: Container(
                          child: Text(
                            'Bestenliste',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          List _items = item[index]['answers'];
                          List<Widget> _answers = [];
                          if (_items != null) {
                            for (var i = 0; i < _items.length; i++) {
                              if (_items[i] == true) {
                                _answers.add(
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                _answers.add(
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                          }

                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Card(
                                child: ExpandablePanel(
                                  header: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            (item.indexOf(item[index]) + 1)
                                                    .toString() +
                                                '. ' +
                                                item[index]['playerName'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  expanded: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, right: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Korrekte Antworten: " +
                                              item[index]['correctAnswers'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        Text(
                                          "Benötigte Zeit: " +
                                              item[index]['timeKeeper'] +
                                              " Sekunden",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        Text(
                                          "Gespielt am: " +
                                              item[index]['gameTime'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 10),
                                          child: Row(
                                            children: _answers,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else
          return Text('');
      },
    );
  }
}
