import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saiphappfinal/Screens/QuizCultureGeneral/model/question_model.dart';
import 'package:saiphappfinal/Screens/QuizCultureGeneral/screens/result_screen/result_screen.dart';
import 'package:saiphappfinal/Screens/QuizCultureGeneral/screens/welcome_screen.dart';

class QuizController2 extends GetxController{

  String name = '';
  BuildContext? ctx = null;
  //question variables
  int get countOfQuestion => _questionsList.length;
  final List<QuestionModel2> _questionsList = [
    QuestionModel2(
      id: 1,
      question:
      "Quel est le plus grand continent du monde ?  ",
      answer: 1,
      options: [' Asie', ' Afrique', ' Europe'],
    ),
    QuestionModel2(
      id: 2,
      question: "Qui est l’inventeur de l’ampoule ?",
      answer: 1,
      options: [' Marc watt', ' Thomas Edison', ' Peter amper'],
    ),
    QuestionModel2(
      id: 3,
      question: "Qui est le peintre de la Joconde ?",
      answer: 2,
      options: [' Léonard de Vinci', ' Claude Monet', ' Pablo picasso '],
    ),
    QuestionModel2(
      id: 4,
      question: "Qui est le premier président des États-Unis d'Amérique ?",
      answer: 1,
      options: [' George Washington', ' Joe biden', ' Gerald Ford'],
    ),
    QuestionModel2(
      id: 5,
      question: "Combien d’océans y a -t- il sur Terre ?",
      answer: 3,
      options: ['3', '7', '5'],
    ),
    QuestionModel2(
      id: 6,
      question: "Quel est le plus grand pays du monde en termes de superficie ?",
      answer: 2,
      options: [' Russie', ' État Unis', ' Inflammation'],
    ),
    QuestionModel2(
      id: 7,
      question: "Sur quel continent se trouve l’Arabie Saoudite ?",
      answer: 3,
      options: [' Asie', ' Afrique', ' Chine'],
    ),
    QuestionModel2(
      id: 8,
      question: "Qui est l'artiste de La Nuit étoilée ?",
      answer: 3,
      options: [' Pablo Picasso', ' Vincent Van Gogh', ' Léonard de Vinci'],
    ),
    QuestionModel2(
      id: 9,
      question: "Quelle est la planète la plus proche de la Terre ? ",
      answer: 2,
      options: [' Mars', ' Mercure', ' Vénus'],
    ),
    QuestionModel2(
      id: 10,
      question: "Quelle est la planète la plus proche du soleil ? ",
      answer: 1,
      options: [' Mercure', ' Vénus', ' Mars'],
    ),
    QuestionModel2(
      id: 11,
      question: "Quelle est la tour la plus haute du monde ?",
      answer: 1,
      options: [' Burj Khalifa', ' Tour Eiffel', ' Worldtrade center'],
    ),
    QuestionModel2(
      id: 12,
      question: "Combien de lettres y a-t-il dans la langue anglaise ?  ",
      answer: 1,
      options: [' 26', ' 32', ' 36'],
    ),
    QuestionModel2(
      id: 13,
      question: "Combien d'yeux a une mouche ",
      answer: 1,
      options: [' 6', ' 8', ' 2'],
    ),
    QuestionModel2(
      id: 14,
      question: "Combien de paupières a un chameau ? ",
      answer: 1,
      options: [' 2', ' 4', ' 3'],
    ),
    QuestionModel2(
      id: 15,
      question: "Quel pays a lancé l'attaque nucléaire sur Hiroshima et Nagasaki ? ",
      answer: 1,
      options: [' Allemagne', ' États unis', ' France'],
    ),
    QuestionModel2(
      id: 16,
      question: "Quelle est la plus haute montagne d'Afrique ? ",
      answer: 1,
      options: [' Le Mont Kilimandjaro', ' Chaambi', ' Djebel Toubkal'],
    ),
    QuestionModel2(
      id: 17,
      question: "Quel est l'animal invertébré le plus intelligent au monde ? ",
      answer: 1,
      options: [' Pieuvre', ' Méduse', 'Étoile de mer'],
    ),
    QuestionModel2(
      id: 18,
      question: "Combien de pays arabes compte le continent africain ? ",
      answer: 1,
      options: [' 9', ' 6', ' 12'],
    ),
    QuestionModel2(
      id: 19,
      question: "Si la tête d’un serpent est séparée de son corps, après combien de temps son cœur s’arrêtera de battre ? ",
      answer: 1,
      options: [' 24', ' 2', ' 1'],
    ),
    QuestionModel2(
      id: 20,
      question: "Combien de pattes a les mille pattes ?",
      answer: 1,
      options: [' 40', ' 1000', ' 24'],
    ),
    QuestionModel2(
      id: 21,
      question: "Si une personne perd un œil, quelle part de sa vision totale perdra-t-elle ?",
      answer: 1,
      options: [' 1/2', ' 1/5', ' 1/3'],
    ),


  ];

  List<QuestionModel2> get questionsList => [..._questionsList];


  bool _isPressed = false;


  bool get isPressed => _isPressed; //To check if the answer is pressed


  double _numberOfQuestion = 1;


  double get numberOfQuestion => _numberOfQuestion;


  int? _selectAnswer;


  int? get selectAnswer => _selectAnswer;


  int? _correctAnswer;


  int _countOfCorrectAnswers = 0;


  int get countOfCorrectAnswers => _countOfCorrectAnswers;

  //map for check if the question has been answered
  final Map<int, bool> _questionIsAnswerd = {};


  //page view controller
  late PageController pageController;

  //timer
  Timer? _timer;


  final maxSec = 15;


  final RxInt _sec = 15.obs;


  RxInt get sec => _sec;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    resetAnswer();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  //get final score
  double get scoreResult {
    return _countOfCorrectAnswers * 100 / _questionsList.length;
  }

  void checkAnswer(QuestionModel2 questionModel, int selectAnswer) {
    _isPressed = true;

    _selectAnswer = selectAnswer;
    _correctAnswer = questionModel.answer;

    if (_correctAnswer == _selectAnswer) {
      _countOfCorrectAnswers++;
    }
    stopTimer();
    _questionIsAnswerd.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500)).then((value) => nextQuestion());
    update();
  }

  //check if the question has been answered
  bool checkIsQuestionAnswered(int quesId) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }

  void nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }

    if (pageController.page == _questionsList.length - 1) {
      Navigator.pushReplacement(ctx!, MaterialPageRoute(builder: (context) => ResultScreen(),));

    } else {
      _isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);

      startTimer();
    }
    _numberOfQuestion = pageController.page! + 2;
    update();
  }

  //called when start again quiz
  void resetAnswer() {
    for (var element in _questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }

  //get right and wrong color
  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green.shade700;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Colors.red.shade700;
      }
    }
    return Color(0xFF273085);
  }

  //het right and wrong icon
  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sec.value > 0) {
        _sec.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }

  void resetTimer() => _sec.value = maxSec;

  void stopTimer() => _timer!.cancel();
  //call when start again quiz
  void startAgain() {
    _correctAnswer = null;
    _countOfCorrectAnswers = 0;
    resetAnswer();
    _selectAnswer = null;
  }
}
