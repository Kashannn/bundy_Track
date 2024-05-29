import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Resourcess/Components/reuseableContainer.dart';
import '../firestore/firebase_service.dart';
import '../provider/Welcome_provider.dart';
import '../utils/routes/routes_name.dart';

class AllocatorScreen extends StatefulWidget {
  const AllocatorScreen({Key? key}) : super(key: key);

  @override
  State<AllocatorScreen> createState() => _AllocatorScreenState();
}

class _AllocatorScreenState extends State<AllocatorScreen> {
  late UserProvider userProvider;
  late int _expandedIndex;
  final FirebaseService _firestoreService = FirebaseService();
  List<DocumentSnapshot> selectedEmployers = [];

  @override
  void initState() {
    super.initState();
    _expandedIndex = -1;
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
                stream: _firestoreService.getRequestOvertimeStream(currentUserId),
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
                      String name = employerData['EmployerName'] ?? 'No Name';
                      String imageUrl = employerData['EmployerImageURL'] ??
                          'https://via.placeholder.com/150';
                      int selectedHours =
                          employerData.containsKey('selected_hours')
                              ? employerData['selected_hours']
                              : 0;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _expandedIndex = _expandedIndex == index ? -1 : index;
                          });
                        },
                        child: _expandedIndex == index
                            ? _buildExpandedItem(index, employer)
                            : _buildListItem(name, imageUrl, selectedHours),
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

  Widget _buildListItem(String name, String imageUrl, int selectedHours) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF1A49F2),
        ),
        child: ListTile(
          trailing: Text(
            '$selectedHours Hours',
            style: TextStyle(color: Colors.white),
          ),
          title: Text(
            name,
            style: TextStyle(color: Colors.white),
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedItem(int index, DocumentSnapshot employer) {
    var employerData = employer.data() as Map<String, dynamic>?;
    String name = employerData?['EmployerName'] ?? 'No Name';
    String imageUrl =
        employerData?['EmployerImageURL'] ?? 'https://via.placeholder.com/150';
    int selectedHours = employerData?['selected_hours'] ?? 0;
    String employerId = employerData?['EmployerId'] ?? '';
    String employeeId = employerData?['EmployeeId'] ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Container(
        color: const Color(0xFF005EE8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFF1A49F2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _firestoreService.addSelectedRequest(
                          employerId: employerId,
                          employeeId: employeeId,
                          name: name,
                          imageUrl: imageUrl,
                          selectedHours: selectedHours,
                        );
                        Navigator.pushNamed(context, RoutesName.overtime);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF34A853),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Text(
                      'Over Time',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFEA4335),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text('No', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
