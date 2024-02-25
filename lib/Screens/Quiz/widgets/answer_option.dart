import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saiphappfinal/Screens/Quiz/controller/quiz_controller.dart';


class AnswerOption extends StatelessWidget {
  const AnswerOption({
    Key? key,
    required this.text,
    required this.index,
    required this.questionId,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final int index;
  final int questionId;
  final Function() onPressed;
//هنا الويدجت بتاععت الاجابات
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      init: Get.find<QuizController>(),
      builder: (controller) => InkWell(
          onTap: controller.checkIsQuestionAnswered(questionId) ? null : onPressed,
          child: Container(
            width: double.infinity,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border:
                Border.all(width: controller.getColor(index)==Color(0xFF273085)?1:3, color: controller.getColor(index))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                        text: '${index + 1}. ',
                        style: TextStyle( color: Color(0xFF273085),),
                        children: [
                          TextSpan(
                            text: text,
                            style: TextStyle(color: Color(0xFF273085),),
                          ),
                        ]),
                  ),
                  if (controller.checkIsQuestionAnswered(questionId) &&
                      controller.selectAnswer == index)
                    Container(
                        width: 30,
                        height: 30,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: controller.getColor(index),
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            shape: BoxShape.circle),
                        child: Icon(
                          controller.getIcon(index),
                          color: Colors.white,
                        ))
                ],
              ),
            ),
          )),
    );
  }
}
