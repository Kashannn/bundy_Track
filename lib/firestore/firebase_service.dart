import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class FirebaseService {
  Utils utils = Utils();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> signUp(String email, String password, String name,
      String department, String position, String imageUrl) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = _auth.currentUser;
      if (user != null) {
        String id = user.uid;
        await _firestore.collection('users').doc(id).set({
          'Name': name,
          'Email': email,
          'Department': department,
          'Position': position,
          'id': id,
          'ImageURL': imageUrl,
        });
        return true; // Sign up successful
      }
      return false; // User is null
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Utils utils = Utils();
      utils.flashBarErrorMessage("Log out successful", context);
      await Future.delayed(Duration(seconds: 1)); // Delay for 1 second
      Navigator.pushNamedAndRemoveUntil(context, '/signInScreen', (route) => false);
    } catch (error) {

      utils.flashBarErrorMessage("Sign out failed: $error", context);
    }
  }

}
