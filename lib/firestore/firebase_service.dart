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

  Future<DocumentSnapshot> getUserData(String uid) async {
    return await _firestore.collection('users').doc(uid).get();
  }

  Future<void> requestOvertime(
      String employeeId, int selectedValue, BuildContext context) async {
    String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    DocumentSnapshot currentUserDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .get();
    Map<String, dynamic>? currentUserData =
    currentUserDoc.data() as Map<String, dynamic>?;

    if (currentUserData != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('RequestOvertime')
          .where('EmployerId', isEqualTo: currentUserId)
          .where('EmployeeId', isEqualTo: employeeId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        try {
          await FirebaseFirestore.instance.collection('RequestOvertime').add({
            'EmployerId': currentUserId,
            'EmployerName': currentUserData['Name'] ?? '',
            'EmployerImageURL': currentUserData['ImageURL'] ?? '',
            'EmployeeId': employeeId,
            'selected_hours': selectedValue,
            'request_time': FieldValue.serverTimestamp(),
          });
          Utils().flashBarErrorMessage('Request sent successfully', context);
          await Future.delayed(Duration(seconds: 1));
          Navigator.pop(context);
        } catch (error) {
          Utils()
              .flashBarErrorMessage('Failed to send request: $error', context);
        }
      } else {
        Utils().flashBarErrorMessage('Request already sent', context);
        await Future.delayed(Duration(milliseconds: 700));
        Navigator.pop(context);
      }
    }
  }

  Stream<QuerySnapshot> getRequestOvertimeStream(String currentUserId) {
    return _firestore
        .collection('RequestOvertime')
        .where('EmployeeId', isEqualTo: currentUserId)
        .snapshots();
  }

  Future<void> addSelectedRequest({
    required String employerId,
    required String employeeId,
    required String name,
    required String imageUrl,
    required int selectedHours,
  }) async {
    try {
      await _firestore.collection('SelectedRequest').doc().set({
        'employerId': employerId,
        'employeeId': employeeId,
        'name': name,
        'imageUrl': imageUrl,
        'selectedHours': selectedHours,
      });
    } catch (e) {
      print('Error adding selected request: $e');
    }
  }

  Stream<QuerySnapshot> getAddSelectedRequest(String currentUserId) {
    return _firestore
        .collection('SelectedRequest')
        .where('employeeId', isEqualTo: currentUserId)
        .snapshots();
  }


}
