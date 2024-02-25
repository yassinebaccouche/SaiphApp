import 'package:saiphappfinal/Screens/QuizCultureGeneral/screens/quiz_screen/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saiphappfinal/Screens/QuizCultureGeneral/screens/result_screen/result_screen.dart';
import 'package:saiphappfinal/Screens/QuizCultureGeneral/screens/welcome_screen.dart';
import 'package:saiphappfinal/Screens/QuizCultureGeneral/utils/bindings_app.dart';

import 'controller/quiz_controller.dart';

class QuizClutureGenerale extends StatefulWidget {
  @override
  _QuizClutureGeneraleState createState() => _QuizClutureGeneraleState();
}

class _QuizClutureGeneraleState extends State<QuizClutureGenerale> {
  final QuizController2 quizController = Get.put(QuizController2());
  @override
  Widget build(BuildContext context) {
    return WelcomeScreen();
  }
}
