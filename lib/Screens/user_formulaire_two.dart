import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:saiphappfinal/Screens/FirstNotifScreen.dart';
import 'package:saiphappfinal/resources/auth-methode.dart'; // Corrected import statement
import 'package:saiphappfinal/widgets/custom_text_field.dart';
import 'package:saiphappfinal/widgets/game_widgets/rounded_button.dart';

import '../Responsive/mobile_screen_layout.dart';
import '../Responsive/responsive_layout_screen.dart';
import '../Responsive/web_screen_layout.dart';
import '../widgets/profile_container.dart';

class UserFormulaireTwo extends StatefulWidget {
  final String pseudo;
  final String date;
  final String tel;
  final String mdp;
  final Uint8List? file;

  UserFormulaireTwo({
    Key? key, // Added key parameter
    required this.pseudo,
    required this.date,
    required this.tel,
    required this.mdp,
    this.file,
  }) : super(key: key); // Fixed constructor

  @override
  State<UserFormulaireTwo> createState() => _UserFormulaireTwoState();
}

class _UserFormulaireTwoState extends State<UserFormulaireTwo> {
  TextEditingController pharmacieController = TextEditingController();
  TextEditingController crmController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool _isLoading = false;
  List<String> professions = [
    'Profession',
    'Pharmacist', // Changed 'Pharamcien' to 'Pharmacist'
    'Doctor', // Changed 'Medecin' to 'Doctor'
    'Profession 3',
    // Add more professions as needed
  ];

  String selectedProfession = 'Profession'; // Default selected profession

  void updateUserInfo() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // Call the AuthMethods updateUser function
    String result = await AuthMethodes().updateUser(
      pseudo: widget.pseudo, // Fixed typo: pesudo to widget.pseudo
      CodeClient: crmController.text,
      phoneNumber: widget.tel, // Changed tel to widget.tel
      pharmacy: pharmacieController.text,
      Datedenaissance: widget.date, // Changed date to widget.date
      photoUrl: widget.file ?? Uint8List(0),
      Verified: '1',
      newEmail: emailController.text,
      newPassword: widget.mdp, // Changed mdp to widget.mdp
      Profession: selectedProfession,
    );

    // Check the result and show appropriate messages or navigate to another screen
    if (result == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
      // User data updated successfully
      // You can navigate to another screen or show a success message
    } else {
      // Some error occurred
      // Display an error message to the user
    }

    // set loading to false after the operation is complete
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      left: false,
      bottom: false,
      top: false,
      right: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF00B2FF).withOpacity(0.5),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ProfileContainer(
                  body: Column(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            "assets/images/profile_pic.png",
                            height: 200,
                            width: 200,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.pseudo,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        "Informations pharmacie",
                        style: TextStyle(
                          color: const Color(0xFF00B2FF),
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          InputField(
                            validatorFunction: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer le Nom de la pharmacie';
                              }
                              return null;
                            },
                            textController: pharmacieController,
                            keyboardType: TextInputType.name,
                            label: "Nom de la pharmacie",
                            prefixIcon: Icons.local_pharmacy_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputField(
                            textController: crmController,
                            validatorFunction: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer le Code';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            label: "Code client CRM",
                            prefixIcon: Icons.group,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputField(
                            textController: emailController,
                            validatorFunction: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            label: "Email",
                            prefixIcon: Icons.group,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: const Color(0xFF00B2FF),
                                width: 1,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Center(
                                child: DropdownButton<String>(
                                  dropdownColor: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  icon: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    child: Transform.rotate(
                                      angle: 90 * pi / 180,
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Color(0xFF00B2FF),
                                      ),
                                    ),
                                  ),
                                  items: professions
                                      .map(
                                        (e) => DropdownMenuItem(
                                      value: e,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ).copyWith(left: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              "$e ",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color:
                                                const Color(0xFF00B2FF),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                      .toList(),
                                  onChanged: (selection) {
                                    setState(() {
                                      selectedProfession = selection!;
                                    });
                                  },
                                  value: selectedProfession,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    RoundedButton(
                      text: "Enregistrer",
                      backgroundColor: const Color(0xFF00B2FF).withOpacity(0.5),
                      strokeColor: Colors.transparent,
                      txtColor: Colors.white,
                      onPressed: () async {
                        updateUserInfo(); // Call the updateUserInfo function
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
