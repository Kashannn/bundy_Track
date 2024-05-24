import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Resourcess/Components/Colors.dart';
import '../utils/routes/routes_name.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String userName = '';
  String userImageUrl = '';
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(currentUser.uid).get();
      setState(() {
        userName = userDoc['Name'] ?? '';
        userImageUrl = userDoc['ImageURL'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              height: 313,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/stackimage1.png', // Replace with your image path
                      fit:
                          BoxFit.cover, // Ensure the image covers the container
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/stackimage2.png', // Replace with your image path
                      width: double.infinity,
                      height: 313,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.menu),
                            onSelected: (String result) {
                              switch (result) {
                                case 'Profile':
                                  Navigator.pushNamed(
                                      context, RoutesName.profile);
                                  break;
                                case 'Logout':
                                  // Implement your logout logic here
                                  break;
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'Profile',
                                child: ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text('Profile'),
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'Logout',
                                child: ListTile(
                                  leading: Icon(Icons.logout),
                                  title: Text('Logout'),
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.container,
                            backgroundImage: userImageUrl.isNotEmpty
                                ? NetworkImage(userImageUrl)
                                : null,
                            child: userImageUrl.isEmpty
                                ? Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                        shape: BoxShape
                            .rectangle, // Use BoxShape.circle for circular images
                      ),
                      child: Image.asset(
                        'assets/images/Logo.png', // Replace with your logo image path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'welcome $userName',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bundy ON',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Poppins',
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Switch(
                          value: isSwitched,
                          onChanged: (bool value) {
                            setState(() {
                              isSwitched = value;
                              if (isSwitched) {
                                // Navigate to the next screen
                                Navigator.pushNamed(
                                    context, RoutesName.timeHours);
                              }
                            });
                          },
                          activeColor: Colors.blue,
                          activeTrackColor: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
