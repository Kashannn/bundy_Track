import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Resourcess/Components/Colors.dart';
import '../Resourcess/Components/imagePicker.dart';
import '../Resourcess/Components/widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
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
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              radius:
                                  15, // Adjust the size of the edit icon as needed
                              backgroundColor:
                                  Colors.white, // Optional: background color
                              child: Image.asset(
                                'assets/images/Editphoto.png', // Path to your edit icon
                                height:
                                    20, // Adjust the size of the edit icon as needed
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$userName',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Flutter Developer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              allText(text: 'Name'),
              allTextField(hintText: 'Name'),
              allText(text: 'Email'),
              allTextField(hintText: 'Email'),
              allText(text: 'Password'),
              allTextField(hintText: 'Password'),
              allText(text: 'Department'),
              allDropdownButton(
                items: ['Department', 'Finance', 'Marketing'],
                value: 'Department',
                onChanged: (String? value) {},
              ),
              allText(text: 'Position'),
              allDropdownButton(
                items: ['Position', 'Finance', 'Marketing'],
                value: 'Position',
                onChanged: (String? value) {},
              ),
              allButton(
                text: 'Save',
                onPressed: () {
                  Navigator.pushNamed(context, '/Allocator');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
