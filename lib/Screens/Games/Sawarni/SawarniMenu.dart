import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DawiniMenu extends StatelessWidget {
  const DawiniMenu({Key? key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width -80;
    return Container(
      width: double.infinity,
      height: 1050,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/rectangle-10-bg-Fp8.jpg'),
        ),
      ),
    );
  }
}
