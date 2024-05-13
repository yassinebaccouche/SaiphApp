import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:saiphappfinal/Screens/SettingScreen.dart';

import 'package:saiphappfinal/Models/user.dart' as model;
import 'package:saiphappfinal/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:saiphappfinal/resources/auth-methode.dart';
import 'package:saiphappfinal/services/notifservice.dart';

import '../Models/user.dart';
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
  bool showNotification = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _page);
    // Initialize with the current page
  }

  Future<User> getUser() async {
    User user = await AuthMethodes().getUserDetails();
    int userScore = int.parse(user.FullScore);
    DateTime lastLoginDate =
        DateTime.fromMillisecondsSinceEpoch(user.lastLogin!);
    int diffDays = DateTime.now().difference(lastLoginDate).inDays;
    print(diffDays);
    if (diffDays == 15) {
      if (userScore > 0) {
        userScore = (userScore * 0.85).toInt();
        showNotification = true;
      }
    } else if (diffDays > 15) {
      int daysExceeded = diffDays - 15;
      for (int i = 0; i < daysExceeded; i++) {
        if (userScore > 0) {
          userScore = (userScore * 0.85).toInt();
          showNotification = true;
        }
      }
    } else {
      showNotification = false;
    }
    // update user lastlogin and score
    AuthMethodes().updateLastLoginAndScore(score: userScore.toString());
    return user;
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
      Icon(Icons.videogame_asset,
          size: 30, color: (_page == 0) ? Colors.white : Colors.white),
      Icon(Icons.add_box_rounded,
          size: 30, color: (_page == 1) ? Colors.white : Colors.white),
      Icon(Icons.shopping_bag,
          size: 30, color: (_page == 2) ? Colors.white : Colors.white),
      Icon(Icons.account_circle,
          size: 30, color: (_page == 3) ? Colors.white : Colors.white),
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(userProvider.getUser.photoUrl),
              // Add user's profile image here
              radius: 20,
            ),
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      body: FutureBuilder<User>(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (showNotification) {
                LocalNotificationService().showLocalNotification(
                    "Activité du Compte",
                    "Votre compte est resté inactif pendant 15 jours. Par conséquent, nous avons réduit vos points de 15 %. Pour éviter de perdre plus de points, connectez-vous régulièrement.");
              }
              return PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: onPageChanged,
                children: homeScreenItems,
              );
            }
          }),
      bottomNavigationBar: CurvedNavigationBar(
        color: CustomColors.lightBlueButton,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
        items: items,
        onTap: navigationTapped,
        index: _page, // Set the initial selected page index
      ),
    );
  }
}
