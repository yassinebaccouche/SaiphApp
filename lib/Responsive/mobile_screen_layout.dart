
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:saiphappfinal/Screens/SettingScreen.dart';


import 'package:saiphappfinal/Models/user.dart' as model;
import 'package:saiphappfinal/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../utils/custom_colors.dart';
import '../utils/global_variables.dart';
class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _page); // Initialize with the current page
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    // Animating Page and updating the selected page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final items = <Widget>[
      Icon(Icons.videogame_asset, size: 30, color: (_page == 0) ? Colors.white : Colors.white),
      Icon(Icons.quiz, size: 30, color: (_page == 1) ? Colors.white : Colors.white),
      Icon(Icons.shopping_bag, size: 30, color: (_page == 2) ? Colors.white : Colors.white),
      Icon(Icons.photo_outlined, size: 30, color: (_page == 3) ? Colors.white : Colors.white),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Image.asset(
          'assets/app_logo.png',
          height: 45,
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(userProvider.getUser.photoUrl), // Add user's profile image here
              radius: 20,
            ),
          ),
          const SizedBox(width: 5,)
        ],
      ),

      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color:  CustomColors.lightBlueButton,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
        items: items,
        onTap: navigationTapped,
        index: _page, // Set the initial selected page index
      ),
    );
  }
}
