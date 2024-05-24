import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _userName = '';
  String _userImageUrl = '';
  bool _isSwitched = false;

  String get userName => _userName;
  String get userImageUrl => _userImageUrl;
  bool get isSwitched => _isSwitched;


  UserProvider() {
    _fetchUserData();
  }


  Future<void> _fetchUserData() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(currentUser.uid).get();
      _userName = userDoc['Name'] ?? '';
      _userImageUrl = userDoc['ImageURL'] ?? '';
      notifyListeners();
    }
  }

  void toggleSwitch(bool value) {
    _isSwitched = value;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
