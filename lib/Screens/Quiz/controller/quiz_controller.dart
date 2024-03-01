import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saiphappfinal/Screens/Quiz/model/question_model.dart';
import 'package:saiphappfinal/Screens/Quiz/screens/result_screen/result_screen.dart';
import 'package:saiphappfinal/Screens/Quiz/screens/welcome_screen.dart';

class QuizController extends GetxController{
  String name = '';
  BuildContext? context=null;
  //question variables
  int get countOfQuestion => _questionsList.length;
  final List<QuestionModel> _questionsList = [
    QuestionModel(
      id: 1,
      question:
      "La dose journalière maximale de ADOL est de:",
      answer: 2,
      options: [' 3G', ' 4G', ' 5G'],
    ),
    QuestionModel(
      id: 2,
      question: "L’intervalle à respecter entre les prises d’ADOL1000 est de :",
      answer: 2,
      options: [' 2h minimum', ' 4h minimum',' 6h minimum'],
    ),
    QuestionModel(
      id: 3,
      question: "ADOL EXTRA:",
      answer: 3,
      options: [' Contient du Paracétamol + Tramadol', ' La boite est de couleur Jaune', ' Le seul Paracétamol Caféiné en Tunisie qui contient 20 Comprimés pour une meilleure observance'],
    ),
    QuestionModel(
      id: 4,
      question: "DYSFEN® la Flurbiprofène de SAIPH est considéré comme le meilleur traitement efficace contre les règles douloureuses Versus tous les AINS:",
      answer: 1,
      options: [' OUI', ' NON'],
    ),
    QuestionModel(
      id: 5,
      question: "DYSFEN® la Flurbiprofène de SAIPH est un Anti-inflammatoire non stéroïdien (AINS) avec une activité:",
      answer: 3,
      options: [' Antalgique', 'Anti-inflammatoire', 'Antalgique, Anti-inflammatoire & Antipyrétique'],
    ),
    QuestionModel(
      id: 6,
      question: "DYSFEN® la Flurbiprofène de SAIPH est indiqué dans:",
      answer: 2,
      options: [' Les Dysménorrhées (Les règles douloureuses)', ' Les Dysménorrhées, l’angine et les infections Rhumatismales'],
    ),
    QuestionModel(
      id: 7,
      question: "Dans votre pratique quotidienne, L’avantage d’utilisation de « Vita D3 ®» de SAIPH par rapport à son concurrent direct Vitamine D3 B.O.N ® d’Opalia :",
      answer: 1,
      options: [' Présence du Code-barres & d’une vignette', ' Présence d’une vignette'],
    ),
    QuestionModel(
      id: 8,
      question: "La Vita B12® de SAIPH est la seule vitamine B12 disponible sur le marché tunisien :",
      answer: 1,
      options: [' VRAI', ' FAUX'],
    ),
    QuestionModel(
      id: 9,
      question: "CYSTODOSE® est la seule fosfomycine made in Tunisia :",
      answer: 1,
      options: [' VRAI', ' FAUX'],
    ),
    QuestionModel(
      id: 10,
      question: "CIPRO Saiph®   est de la famille des Fluoroquinolones :",
      answer: 1,
      options: [' VRAI', ' FAUX'],
    ),



  ];

  List<QuestionModel> get questionsList => [..._questionsList];


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
  int get scoreResult {
    return _countOfCorrectAnswers ;
  }

  void checkAnswer(QuestionModel questionModel, int selectAnswer) {
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
      //Get.offAndToNamed('/result_screen1');
      Navigator.pushReplacement(context!, MaterialPageRoute(builder: (context) => ResultScreen(),));
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
