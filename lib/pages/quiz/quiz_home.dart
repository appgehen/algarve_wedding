import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/fadein_animation.dart';
import 'quiz_logic.dart';
import 'quiz_questions.dart';
import 'quiz_loadquestions.dart';
import 'widgets/home_header.dart';
import 'widgets/result_list.dart';
import 'package:algarve_wedding/widgets/build_intro-text/intro-text_streambuilder.dart';
import 'widgets/cheating_dialog.dart';
import 'widgets/result_list_bestof.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool _validate = false;
  TextEditingController _inputPlayerName = new TextEditingController();

  @override
  void initState() {
    super.initState();
    addQuizQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        getHomeHeader(context),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FadeIn(
                  1,
                  Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              returnIntroStreamBuilder(introTexts, 'introTexts',
                                  'quizHome', context),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Spielername',
                                        errorText: _validate
                                            ? 'Bitte trage einen Spielernamen ein.'
                                            : null,
                                        labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).focusColor),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Theme.of(context).focusColor),
                                        ),
                                      ),
                                      controller: _inputPlayerName,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0,
                                          left: 20,
                                          right: 20,
                                          bottom: 20),
                                      child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        height: 50,
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        color: Theme.of(context).primaryColor,
                                        textColor: Colors.white,
                                        child: Text('Quiz starten'),
                                        onPressed: () {
                                          _startQuiz(context);
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
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                        child: Container(
                          child: Text(
                            'Ewige Champions',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                      bestOfResultList(
                          context, 'quizResultListBestOf', 'Februar 2021'),
                      bestOfResultList(
                          context, 'quizResultListBestOf_May', 'Mai 2021'),
                      BuildResultList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _startQuiz(BuildContext context) {
    playerName = _inputPlayerName.text;
    if (_inputPlayerName.text.length > 0) {
      setState(() {
        _validate = false;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizQuestionsNew(),
            )).then((data) {
          setState(() {
            FocusScope.of(context).requestFocus(FocusNode());
            if (quizQuestions.length - 1 != quizQuestionNumber) {
              print(quizQuestions.length);
              saveResultInDatabase();
              showDialog(
                  context: context,
                  builder: (_) => returnCheatDialogue(context));
            }
            resetQuiz();
          });
        });
      });
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}
