import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Resourcess/Components/reuseableContainer.dart';
import '../firestore/firebase_service.dart';
import '../provider/Welcome_provider.dart';

class Overtime extends StatefulWidget {
  const Overtime({super.key});

  @override
  State<Overtime> createState() => _OvertimeState();
}

class _OvertimeState extends State<Overtime> {
  late UserProvider userProvider;
  final FirebaseService _firestoreService = FirebaseService();

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ReusableContainer(
              name: userProvider.userName,
              circularImageUrl: userProvider.userImageUrl,
            ),
            SizedBox(height: 30),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestoreService.getAddSelectedRequest(currentUserId),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No employers found'));
                  }
      
                  List<DocumentSnapshot> employers = snapshot.data!.docs;
      
                  return ListView.builder(
                    itemCount: employers.length,
                    itemBuilder: (BuildContext context, int index) {
                      var employer = employers[index];
                      var employerData = employer.data() as Map<String, dynamic>?;
      
                      if (employerData == null) {
                        return ListTile(
                          title: Text('No data available'),
                        );
                      }
      
                      String name = employerData['name'] ?? 'No Name';
                      String imageUrl = employerData['imageUrl'] ??
                          'https://via.placeholder.com/150';
                      int selectedHours =
                          employerData.containsKey('selected_hours')
                              ? employerData['selected_hours']
                              : 0;
      
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF34A853),
                          ),
                          child: ListTile(
                            title: Text(name),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(imageUrl),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                employer.reference.delete();
                              },
                            ),
                            subtitle: Text("Overtime Request"),
                          ),
                        ),
                      );
                    },
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
