import 'package:bundy_track/Resourcess/Components/reuseableContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Selection extends StatefulWidget {
  const Selection({super.key});

  @override
  State<Selection> createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
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
        body: Column(
      children: [
        ReusableContainer(
          name: '$userName',
          circularImageUrl: '$userImageUrl',
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 5, // Number of items in the list
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Container(
                  color: const Color(0xFF34A853),
                  child: ListTile(
                    title: Text(
                      'Kashan Ashraf',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 23,
                      ),
                    ),
                    trailing: Icon(
                      Icons.check_box_outlined,
                      color: Colors.white,
                    ),

                  ),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
