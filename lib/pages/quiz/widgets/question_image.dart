import 'package:flutter/material.dart';
import 'package:algarve_wedding/logic/return_storage-image.dart';
import 'package:algarve_wedding/pages/quiz/quiz_logic.dart';
import 'package:cached_network_image/cached_network_image.dart';

ReturnStorageImage _returnStorageImage = ReturnStorageImage();
Widget getQuestionImage(context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: FutureBuilder(
      future: _returnStorageImage
          .getImageURL("quizImages/quiz-${quizQuestionNumber + 1}.webp"),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Image(
          image: CachedNetworkImageProvider((snapshot.data).toString()),
          fit: BoxFit.cover,
        );
      },
    ),
  );
}
