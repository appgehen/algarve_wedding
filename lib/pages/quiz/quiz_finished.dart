import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:algarve_wedding/widgets/fadein_animation.dart';
import 'quiz_logic.dart';
import 'quiz_loadquestions.dart';
import 'widgets/result_list.dart';
import 'widgets/button_finishquiz.dart';
import '../../logic/shared-prefs/save_prefs.dart';

class QuizFinished extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Wie gut kennst Du Portugal, " + playerName + "?"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 30),
          child: FadeIn(
            1,
            Column(
              children: [
                returnSummary(context),
                BuildResultList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget returnSummary(BuildContext context) {
  if (correctAnswers == quizQuestions.length) {
    saveSharedPrefs('aPausaVisibility', 'true');
    return Column(
      children: [
        Container(
          width: 250,
          child: Lottie.asset('assets/quiz_success.json'),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Bist Du ein Reiseführer, ' + playerName + '?',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Du hast alle ' +
                        correctAnswers.toString() +
                        ' Fragen richtig beantwortet. PSSST: Du hast Dir damit die Infos zu unserer Location freigespielt. Schau mal in den \"Portugal\" Tab. 😉',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                buttonFinishQuiz(context),
              ],
            ),
          ),
        ),
      ],
    );
  } else if (correctAnswers >= quizQuestions.length - 5) {
    return Column(
      children: [
        Container(
          width: 250,
          child: Lottie.asset('assets/quiz_goodresult.json'),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Herzlichen Glückwunsch, ' + playerName + '!',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Du hast ' +
                        correctAnswers.toString() +
                        ' von ' +
                        quizQuestions.length.toString() +
                        ' Fragen richtig beantwortet. Noch fehlen Dir ein paar richtige Antworten für die Überraschung.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                buttonFinishQuiz(context),
              ],
            ),
          ),
        ),
      ],
    );
  } else {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: 200,
            child: Lottie.asset('assets/quiz_badresult.json'),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Nachhilfe gefällig, ' + playerName + '?',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Du hast nur ' +
                        correctAnswers.toString() +
                        ' von ' +
                        quizQuestions.length.toString() +
                        ' Fragen richtig beantwortet. Gerne leihen wir Dir unseren Portugal Reiseführer, damit Du Dich noch etwas informieren kannst. 🙃',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                buttonFinishQuiz(context),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
