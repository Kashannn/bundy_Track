import 'package:bundy_track/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _userName = '';
  String _userImageUrl = '';
  String _password = '';
  String _position = '';
  String _department = '';
  String _email = '';
  int _selectedHours = 0;
  bool _isSwitched = false;
  String _role = '';
  List<Map<String, dynamic>> _usersList = [];

  String get userName => _userName;
  String get userImageUrl => _userImageUrl;
  String get password => _password;
  String get position => _position;
  String get department => _department;
  String get email => _email;
  int get selectedHours => _selectedHours;
  String get role => _role;
  List<Map<String, dynamic>> get usersList => _usersList;

  bool get isSwitched => _isSwitched;

  UserProvider() {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      _userName = userData['Name'] ?? '';
      _userImageUrl = userData['ImageURL'] ?? '';
      _password = userData['Password'] ?? '';
      _department = userData['Department'] ?? '';
      _email = userData['Email'] ?? '';
      _position = userData['Position'] ?? '';
      _selectedHours = userData['selected_hours'] ?? 0;
      _role = userData['role'] ?? '';
      notifyListeners();
    }
  }

  set userName(String name) {
    _userName = name;
    notifyListeners();
  }

  set userImageUrl(String url) {
    _userImageUrl = url;
    notifyListeners();
  }

  set password(String pass) {
    _password = pass;
    notifyListeners();
  }

  set position(String pos) {
    _position = pos;
    notifyListeners();
  }

  set department(String dept) {
    _department = dept;
    notifyListeners();
  }

  set email(String mail) {
    _email = mail;
    notifyListeners();
  }

  set selectedHours(int hours) {
    _selectedHours = hours;
    notifyListeners();
  }

  set role(String r) {
    _role = r;
    notifyListeners();
  }

  set usersList(List<Map<String, dynamic>> users) {
    _usersList = users;
    notifyListeners();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  void updateUserData(
      String name, String department, String position, String imageUrl) {
    _userName = name;
    _department = department;
    _position = position;
    _userImageUrl = imageUrl;
    notifyListeners();
  }

  void toggleSwitch(bool value) {
    _isSwitched = value;
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth
          .signOut()
          .then((value) => Utils.toastMessage('Log out successful'));
      await Future.delayed(Duration(seconds: 1));
      Navigator.pushNamed(context, '/signInScreen');
    } catch (error) {
      print('Sign out failed: $error');
    }
  }
}

Future<bool> updateUserRecord(String uid, String name, String department,
    String position, String imageUrl) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'Name': name,
      'Department': department,
      'Position': position,
      'ImageURL': imageUrl,
    });
    return true;
  } catch (e) {
    print('Error updating user record: $e');
    return false;
  }
}
