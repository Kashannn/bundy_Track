import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Resourcess/Components/reuseableContainer.dart';
import '../firestore/firebase_service.dart';
import '../provider/Welcome_provider.dart';

class Overtime extends StatefulWidget {
  const Overtime({super.key});

  @override
  State<Overtime> createState() => OvertimeState();
}

class OvertimeState extends State<Overtime> {
  late UserProvider userProvider;
  final FirebaseService _firestoreService = FirebaseService();

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ReusableContainer(
            name: userProvider.userName,
            circularImageUrl: userProvider.userImageUrl,
          ),
          SizedBox(height: 30),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestoreService.getSelectedEmployers(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No employees found'));
                }

                List<DocumentSnapshot> users = snapshot.data!.docs;

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      var user = users[index];
                      var userData = user.data() as Map<String, dynamic>?;
                      if (userData == null) {
                        return ListTile(
                          title: Text('No data available'),
                        );
                      }
                      String name = userData['Name'] ?? 'No Name';
                      String imageUrl = userData['ImageURL'] ?? 'https://via.placeholder.com/150';
                      int selectedHours = userData.containsKey('selected_hours')
                          ? userData['selected_hours']
                          : 0;

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          tileColor: Color(0xFF34A853),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(width: 1),
                          ),
                          title: Text(
                            name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Delete the document and update the state
                              _firestoreService.removeSelectedEmployer(user.id);
                              setState(() {}); // Force rebuild
                            },
                          ),
                          subtitle: Text(
                            'Overtime',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(imageUrl),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}