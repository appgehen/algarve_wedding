import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class AddImage extends StatefulWidget {
  final String galleryName;
  final String gallery;
  const AddImage({Key key, this.galleryName, this.gallery}) : super(key: key);
  @override
  _AddImageState createState() =>
      _AddImageState(galleryName: this.galleryName, gallery: this.gallery);
}

class _AddImageState extends State<AddImage> {
  String galleryName;
  String gallery;
  _AddImageState({this.galleryName, this.gallery});

  List<XFile> _imageFileList;

  bool uploading = false;
  double val = 0;
  CollectionReference imgRef;
  firebase_storage.Reference ref;
  List<File> _image = [];
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection(gallery.toString());
    if (!uploading) {
      chooseImage();
    }
  }

  void chooseImage() async {
    await selectImages();
    _imageFileList.forEach((element) {
      setState(() {
        _image.add(File(element.path));
        if (element.path == null) retrieveLostData();
      });
    });
  }

  void selectImages() async {
    final pickedFileList = await picker.pickMultiImage(imageQuality: 70);
    setState(() {
      _imageFileList = pickedFileList;
    });
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    int i = 1;
    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child(gallery.toString() + '/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({'url': value});
          i++;
        });
      });
    }
  }

  Widget uploadImagesCTA() {
    if (_image.length >= 1) {
      return FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            uploading = true;
          });
          uploadFile().whenComplete(
              () => Navigator.of(context).popUntil((route) => route.isFirst));
        },
        label: Text(
          'Hochladen',
          style: Theme.of(context).textTheme.headline2,
        ),
        backgroundColor: Theme.of(context).accentColor,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bilder auswählen'),
      ),
      floatingActionButton: uploadImagesCTA(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            child: GridView.builder(
                itemCount: _image.length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return index == 0
                      ? Center(
                          child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () =>
                                  !uploading ? chooseImage() : null),
                        )
                      : Container(
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(_image[index - 1]),
                                  fit: BoxFit.cover)),
                        );
                }),
          ),
          uploading
              ? Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: Text(
                              'Lade Deine Bilder hoch...',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CircularProgressIndicator(
                            value: val,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
