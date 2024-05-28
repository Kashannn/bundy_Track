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
      String department, String position, String imageUrl, String role) async {
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
          'role': role,
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
      Navigator.pushNamedAndRemoveUntil(
          context, '/signInScreen', (route) => false);
    } catch (error) {
      utils.flashBarErrorMessage("Sign out failed: $error", context);
    }
  }

  Stream<QuerySnapshot> getEmployeesStream() {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'Employee')
        .snapshots();
  }

  Stream<QuerySnapshot> getEmployersStream() {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'Employer')
        .snapshots();
  }

  Stream<QuerySnapshot> getUsersStream() {
    return _firestore.collection('users').snapshots();
  }

  Future<void> addSelectedEmployer(DocumentSnapshot employer) async {
    await _firestore
        .collection('selectedEmployers')
        .doc(employer.id)
        .set(employer.data() as Map<String, dynamic>);
    await _firestore.collection('employers').doc(employer.id).delete();
  }

  Future<void> addToSelectedRequest(
      String documentId, Map<String, dynamic>? data) async {
    try {
      await _firestore
          .collection('SelectedRequest')
          .doc(documentId)
          .set(data ?? {});
    } catch (e) {
      print('Error adding to SelectedRequest: $e');
    }
  }

  Stream<QuerySnapshot> getSelectedEmployers() {
    return _firestore.collection('SelectedRequest').snapshots();
  }

  Future<DocumentSnapshot> getUserData(String uid) async {
    return await _firestore.collection('users').doc(uid).get();
  }

  Future<void> removeSelectedEmployer(String documentId) async {
    try {
      print('Attempting to remove document with ID: $documentId');
      await _firestore.collection('SelectedRequest').doc(documentId).delete();
      print('Document removed successfully');
    } catch (e) {
      print('Error removing document: $e');
    }
  }

  Future<void> requestOvertime(String employeeId, String name, String imageUrl,
      int selectedHours, BuildContext context) async {
    String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    await FirebaseFirestore.instance.collection('RequestOvertime').add({
      'EmployerId': currentUserId,
      'EmployeeId': employeeId,
      'Name': name,
      'ImageURL': imageUrl,
      'selected_hours': selectedHours,
      'request_time': FieldValue.serverTimestamp(),
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Overtime request sent')));
  }

  Stream<QuerySnapshot> getRequestOvertimeStream(String currentUserId) {
    return _firestore.collection('RequestOvertime').snapshots();
  }

}
