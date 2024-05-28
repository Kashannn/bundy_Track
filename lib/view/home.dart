import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../Resourcess/Components/digitbutton.dart';
import '../Resourcess/Components/reuseableContainer.dart';
import '../Resourcess/Components/widget.dart';
import '../firestore/firebase_service.dart';
import '../provider/Welcome_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedValue = 0;
  late UserProvider userProvider;
  final FirebaseService _firestoreService = FirebaseService();
  late Map<String, dynamic> _selectedUserData;

  Future<void> _storeSelectedValue() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(userId).set({
      'selected_hours': _selectedValue,
    }, SetOptions(merge: true));
  }

  void _onValueChanged(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: ReusableContainer(
                name: userProvider.userName,
                circularImageUrl: userProvider.userImageUrl,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestoreService.getEmployeesStream(),
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
                  users.sort((a, b) {
                    int selectedHoursA = (a.data() as Map<String, dynamic>?)?.containsKey('selected_hours') ?? false
                        ? a['selected_hours']
                        : 0;
                    int selectedHoursB = (b.data() as Map<String, dynamic>?)?.containsKey('selected_hours') ?? false
                        ? b['selected_hours']
                        : 0;
                    return selectedHoursA.compareTo(selectedHoursB);
                  });

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
                        int selectedHours = userData.containsKey('selected_hours') ? userData['selected_hours'] : 0;
                        String employerId = user.id;

                        return GestureDetector(
                          onTap: () {
                            _selectedUserData = userData;
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          title: Text(
                                            name,
                                            style: TextStyle(fontSize: 20, color: Colors.white),
                                          ),
                                          trailing: Text(
                                            '$selectedHours hours',
                                            style: TextStyle(fontSize: 16, color: Colors.white),
                                          ),
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(imageUrl),
                                            backgroundColor: Colors.white,
                                          ),
                                          tileColor: Color(0xFF0063F5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: BorderSide(width: 2),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        DigitButton(
                                          onValueChanged: _onValueChanged,
                                        ),
                                        SizedBox(height: 20),
                                        Center(
                                          child: allButton(
                                            onPressed: () {
                                              _storeSelectedValue();
                                              _firestoreService.requestOvertime(employerId, name, imageUrl, selectedHours, context);
                                            },
                                            text: 'Request OverTime',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              tileColor: Color(0xFF0063F5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(width: 2),
                              ),
                              title: Text(
                                name,
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              trailing: Text(
                                '$selectedHours hours',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(imageUrl),
                                backgroundColor: Colors.white,
                              ),
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
      ),
    );
  }

}
