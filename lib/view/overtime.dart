import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Resourcess/Components/reuseableContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Overtime extends StatefulWidget {
  final List<DocumentSnapshot> selectedEmployers;

  Overtime({Key? key, required this.selectedEmployers}) : super(key: key);

  @override
  State<Overtime> createState() => _OvertimeState();
}

class _OvertimeState extends State<Overtime> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userName = '';
  String userImageUrl = '';

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

  void _removeEmployer(int index) {
    setState(() {
      widget.selectedEmployers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ReusableContainer(
              name: userName,
              circularImageUrl: userImageUrl,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.selectedEmployers.length,
                itemBuilder: (BuildContext context, int index) {
                  var employerData = widget.selectedEmployers[index].data()
                      as Map<String, dynamic>?;
                  String name = employerData?['Name'] ?? 'No Name';
                  String imageUrl = employerData?['ImageURL'] ??
                      'https://via.placeholder.com/150';

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF34A853),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                      title: Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        'Overtime',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          _removeEmployer(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
