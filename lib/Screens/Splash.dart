import 'package:flutter/material.dart';
import 'dart:async';
import 'package:saiphappfinal/Screens/SignInScreen.dart'; // Remove the extra space here

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay and navigate to the next screen
    Timer(
      Duration(seconds: 4), // Adjust the duration as needed
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()), // Replace NextScreen with the screen you want to navigate to
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 350;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Container(
          width: double.infinity,
          height: 1050 * fem,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/backgroundSignin.png'),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 61 * fem,
                top: 135 * fem,
                child: Align(
                  child: SizedBox(
                    width: 270 * fem,
                    height: 590 * fem,
                    child: Image.asset(
                      'assets/char.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 90.4443359375 * fem,
                top: 50.7479248047 * fem,
                child: Align(
                  child: SizedBox(
                    width: 250.78 * fem,
                    height: 96.81 * fem,
                    child: Image.asset(
                      'assets/accroche-adol-1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
