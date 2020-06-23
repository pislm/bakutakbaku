import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'brain.dart';
import 'katabaku.dart';
import 'dart:math';

void main() => runApp(BakuTakBaku());

class BakuTakBaku extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baku Tak Baku',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Baku Tak Baku',
            // style: TextStyle(
            //   color: Colors.teal,
            //   fontWeight: FontWeight.bold,
            // ),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static Brain otak = Brain();
  int questionNumber = 0;
  int answeredCorrect = 0;
  double correctPercentage = 0;
  KataBaku currentKata = Brain.startingKata;
  int correctAnswer = Brain.startingAnswer;
  String option1 = Brain.startingOption1;
  String option2 = Brain.startingOption2;

  void changeKata() {
    currentKata = otak.getRandomKata();
    correctAnswer = Random().nextInt(2);
    option1 =
        correctAnswer == 0 ? currentKata.getBenar() : currentKata.getSalah();
    option2 =
        correctAnswer == 1 ? currentKata.getBenar() : currentKata.getSalah();
  }

  void chooseCorrect() {
    String ans = currentKata.getBenar();
    Alert(
      context: context,
      type: AlertType.success,
      title: 'Jawaban Benar!',
      desc: ans,
      buttons: [
        DialogButton(
          child: Text(
            'Yey!',
            style: TextStyle(
              color: Colors.white,
              // fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ).show();
    questionNumber++;
    answeredCorrect++;
    correctPercentage =
        num.parse((100 * answeredCorrect / questionNumber).toStringAsFixed(2));
    changeKata();
  }

  void chooseFalse() {
    String ans = currentKata.getBenar();
    Alert(
      context: context,
      type: AlertType.error,
      title: 'Jawaban Salah!',
      desc: 'Jawaban yang benar adalah $ans',
      buttons: [
        DialogButton(
          child: Text(
            'Oke, diingat!',
            style: TextStyle(
              color: Colors.white,
              // fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ).show();
    questionNumber++;
    correctPercentage =
        num.parse((100 * answeredCorrect / questionNumber).toStringAsFixed(2));
    changeKata();
  }

  TextStyle optionButtonStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10),
        Text('   Jumlah Benar/Soal: $answeredCorrect/$questionNumber'),
        Text('   Persentase Benar : $correctPercentage%'),
        SizedBox(
          height: 10,
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              questionNumber = 0;
              answeredCorrect = 0;
              correctPercentage = 0;
            });
          },
          child: Text(
            'Reset Skor',
            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              'Manakah yang baku?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: FlatButton(
              color: Colors.teal,
              onPressed: () {
                setState(() {
                  if (correctAnswer == 0)
                    chooseCorrect();
                  else
                    chooseFalse();
                });
              },
              child: Text(
                option1,
                style: optionButtonStyle(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: FlatButton(
              color: Colors.teal,
              onPressed: () {
                setState(() {
                  if (correctAnswer == 1)
                    chooseCorrect();
                  else
                    chooseFalse();
                });
              },
              child: Text(
                option2,
                style: optionButtonStyle(),
              ),
            ),
          ),
        ),
        Expanded(child: Text(' '), flex: 3)
      ],
    );
  }
}
