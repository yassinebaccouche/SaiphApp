import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:saiphappfinal/Screens/QuizCultureGeneral/controller/quiz_controller.dart';

import 'package:saiphappfinal/Screens/QuizCultureGeneral/model/question_model.dart';

import 'answer_option.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel2 questionModel; // Adjust the type based on your actual QuestionModel type


  const QuestionCard({
    Key? key,
    required this.questionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          height: 450,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  questionModel.question,
                   style: TextStyle(
                color: Color(0xFF273085),
               fontSize: 30,
                fontWeight: FontWeight.bold,
               ),


      ),
                //const SizedBox(height: 15),
                const Spacer(
                  flex: 1,
                ),
                ...List.generate(
                    questionModel.options.length,
                        (index) => Column(
                      children: [
                        AnswerOption(
                            questionId: questionModel.id,
                            text: questionModel.options[index],
                            index: index,
                            onPressed: () => Get.find<QuizController2>()
                                .checkAnswer(questionModel, index)),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    )),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          )),
    );
  }
}
