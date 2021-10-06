import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:algarve_wedding/widgets/build_cards/listview_streambuilder.dart';
import 'news_pickimage.dart';
import 'news_add_imagepreview.dart';

TextEditingController _imageDescription = new TextEditingController();
TextEditingController _imageHeadline = new TextEditingController();
TextEditingController _subline = new TextEditingController();
TextEditingController _timeStamp = new TextEditingController();
String _imagePath;

var newsListRef = FirebaseDatabase().reference().child('roadToPortugal');

class AddNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Erstelle ein neues Posting"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: GestureDetector(
                    child: cardImage(context),
                    onTap: () {
                      redirectUpload(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Headline',
                          /*errorText: _validate
                            ? 'Bitte trage einen Spielernamen ein.'
                            : null,*/
                          labelStyle:
                              TextStyle(color: Theme.of(context).focusColor),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).focusColor),
                          ),
                        ),
                        controller: _imageHeadline,
                      ),
                      TextField(
                        maxLines: 8,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Posting',
                          /*errorText: _validate
                            ? 'Bitte trage einen Spielernamen ein.'
                            : null,*/
                          labelStyle:
                              TextStyle(color: Theme.of(context).focusColor),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).focusColor),
                          ),
                        ),
                        controller: _imageDescription,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Subline (optional)',
                          /*errorText: _validate
                            ? 'Bitte trage einen Spielernamen ein.'
                            : null,*/
                          labelStyle:
                              TextStyle(color: Theme.of(context).focusColor),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).focusColor),
                          ),
                        ),
                        controller: _subline,
                      ),
                      TextField(
                        scrollPadding: EdgeInsets.only(bottom: 40),
                        decoration: InputDecoration(
                          labelText: 'Datum',
                          /*errorText: _validate
                            ? 'Bitte trage einen Spielernamen ein.'
                            : null,*/
                          labelStyle:
                              TextStyle(color: Theme.of(context).focusColor),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).focusColor),
                          ),
                        ),
                        controller: _timeStamp,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20, right: 20, bottom: 20),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          height: 50,
                          minWidth: MediaQuery.of(context).size.width,
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Text('Posting erstellen'),
                          onPressed: () {
                            addNews(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void addNews(BuildContext context) {
  newsListRef.push().set({
    'imageDescription': _imageDescription.text.toString(),
    'imageHeadline': _imageHeadline.text.toString(),
    'imagePath': "roadToPortugal/" + _imagePath.toString(),
    'sortingOrder': roadToPortugal.length,
    'subline': _subline.text.toString(),
    'timeStamp': _timeStamp.text.toString()
  }).then((value) => resetList(context));
}

void resetList(BuildContext context) async {
  await clearInputs();
  Navigator.pop(context);
}

void clearInputs() async {
  _imageDescription.clear();
  _imageHeadline.clear();
  _subline.clear();
  _timeStamp.clear();
}

void redirectUpload(BuildContext context) async {
  final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddImage(),
      ));

  _imagePath = result.toString();
}
