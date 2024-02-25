import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saiphappfinal/Screens/QuizCultureGeneral/controller/quiz_controller.dart';
import 'package:saiphappfinal/Screens/QuizCultureGeneral/widgets/custom_button.dart';
import 'package:saiphappfinal/Screens/QuizCultureGeneral/widgets/progress_timer.dart';
import 'package:saiphappfinal/Screens/QuizCultureGeneral/widgets/question_card.dart';

import '../../../../Responsive/mobile_screen_layout.dart';
import '../../../../Responsive/responsive_layout_screen.dart';
import '../../../../Responsive/web_screen_layout.dart';


class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration:  BoxDecoration(
              gradient: RadialGradient(radius: 2, colors: [
                Color(0xff1331C4).withOpacity(0.1),
                Color(0xff1331C4).withOpacity(0.2),
                Color(0xff1331C4).withOpacity(0.3),
                Color(0xff1331C4).withOpacity(0.4),
                Color(0xff1331C4).withOpacity(0.5)
              ]),
            ),
          ),
          SafeArea(
            child: GetBuilder<QuizController2>(
              init: QuizController2(),
              builder: (controller) => SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Question ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: Color(0xFF273085)),
                                children: [
                                  TextSpan(
                                      text: controller.numberOfQuestion
                                          .round()
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(color: Color(0xFF273085))),
                                  TextSpan(
                                      text: '/',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Color(0xFF273085))),
                                  TextSpan(
                                      text: controller.countOfQuestion.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Color(0xFF273085))),
                                ]),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                "assets/images/close_icon.svg",
                                width: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 450,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => QuestionCard(
                          questionModel: controller.questionsList[index],
                        ),
                        controller: controller.pageController,
                        itemCount: controller.questionsList.length,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: GetBuilder<QuizController2>(
        init: QuizController2(),
        builder: (controller){
          controller.ctx=context;
          return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [SizedBox(),ProgressTimer(),

              FloatingActionButton.extended(
                icon: Icon(Icons.arrow_forward_ios,color: Colors.white,),backgroundColor: Color(0xFF273085),
                onPressed: (){controller.nextQuestion();},
                label: Text(
                  'Suivant',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white), // Set text color to black
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
