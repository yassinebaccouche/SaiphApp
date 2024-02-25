import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saiphappfinal/Screens/QuizCultureGeneral/controller/quiz_controller.dart';
import 'package:saiphappfinal/Screens/QuizCultureGeneral/screens/quiz_screen/quiz_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _submit(context) {
    FocusScope.of(context).unfocus();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => QuizScreen(),));
    Get.find<QuizController2>().startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(leading: SizedBox(),backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [GestureDetector(onTap: () {
          Navigator.pop(context);
        },
          child: Padding(padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              "assets/images/close_icon.svg", width: 25,),),)
        ],
        //   backgroundColor: Colors.transparent,
      ),
      body: Container(constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(gradient: RadialGradient(radius: 2,
            colors: [
              Color(0xff1331C4).withOpacity(0.1),
              Color(0xff1331C4).withOpacity(0.2),
              Color(0xff1331C4).withOpacity(0.3),
              Color(0xff1331C4).withOpacity(0.4),
              Color(0xff1331C4).withOpacity(0.5)
            ]),),
        child: Padding(padding: const EdgeInsets.all(15.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: FloatingActionButton.large(
                heroTag: null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(500)),
                onPressed: () => _submit(context),
                backgroundColor: Color(0xFF273085),
                child: Icon(
                  Icons.play_arrow_rounded, color: Colors.white, size: 70,),)),
            ],),),),);
  }
}
