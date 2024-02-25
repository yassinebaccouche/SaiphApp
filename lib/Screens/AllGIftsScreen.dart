import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saiphappfinal/Models/Gift.dart';
import 'package:saiphappfinal/providers/user_provider.dart';
import 'package:saiphappfinal/resources/firestore_methods.dart';
import 'package:provider/provider.dart';

class AllGiftsScreen extends StatefulWidget {
  const AllGiftsScreen({Key? key}) : super(key: key);

  @override
  _AllGiftsScreenState createState() => _AllGiftsScreenState();
}

class _AllGiftsScreenState extends State<AllGiftsScreen> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final GiftManager giftManager = GiftManager();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Points et Cadeaux',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Color(0xFF273085),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF273085),
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 330,
                height: 30,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text(
                        'Vous avez: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.grey,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    Text(
                      '${userProvider.getUser.FullScore}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Color(0xFF273085),
                      ),
                    ),
                    Text(
                      ' Points',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Color(0xFF273085),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              FutureBuilder<List<GiftModel>>(
                future: giftManager.getAllGifts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.red));
                  } else {
                    List<GiftModel>? giftList = snapshot.data;
                    if (giftList != null && giftList.isNotEmpty) {
                      return Column(
                        children: giftList.map((gift) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showDialog('${gift.code}', int.parse(userProvider.getUser.FullScore));

                                },
                                child: Container(
                                  width: 307.17,
                                  height: 54,
                                  decoration: BoxDecoration(
                                    color: Color(0xff273085),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${gift.card}...${gift.points} Points',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(
                        child: Text(
                          'No gifts available. 😔',
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(String giftCode, int userFullScore) async {
    String claimResult = await GiftManager().claimGift(giftCode, userFullScore);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Claim Gift"),
          content: Text(claimResult),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

class GiftManager {
  Future<List<GiftModel>> getAllGifts() {
    return FireStoreMethods().getAllGifts();
  }

  Future<String> claimGift(String giftCard, int userFullScore) async {
    try {
      DocumentSnapshot giftSnapshot = await FirebaseFirestore.instance.collection('gifts').doc(giftCard).get(); // Fetch gift by code
      if (!giftSnapshot.exists) {
        return 'Gift not found';
      }

      Map<String, dynamic> giftData = giftSnapshot.data() as Map<String, dynamic>; // Provide type information

      bool isUsed = giftData['isUsed'] ?? false; // Access 'isUsed' field
      if (isUsed) {
        return 'Gift is already used';
      }

      int pointsRequired = giftData['points'] ?? 0; // Access 'points' field

      if (userFullScore < pointsRequired) {
        return 'Insufficient points to claim the gift';
      }

      int newFullScore = userFullScore - pointsRequired;

      // Replace 'USER_ID' with actual user ID
      await FirebaseFirestore.instance.collection('users').doc('USER_ID').update({'FullScore': newFullScore}); // Update user's full score

      await FirebaseFirestore.instance.collection('gifts').doc(giftCard).update({'isUsed': true}); // Mark gift as used

      return 'Gift claimed successfully';
    } catch (error) {
      return 'Error claiming gift: $error';
    }
  }
}
