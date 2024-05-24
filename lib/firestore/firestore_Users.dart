import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireStoreUser extends StatefulWidget {
  const FireStoreUser({super.key});

  @override
  State<FireStoreUser> createState() => _FireStoreUserState();
}

class _FireStoreUserState extends State<FireStoreUser> {

 final auth = FirebaseAuth.instance;
 final ref = FirebaseFirestore.instance.collection('users');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController _departmentDropdownController = TextEditingController();
  final TextEditingController _positionDropdownController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    departmentController.dispose();
    positionController.dispose();
    _departmentDropdownController.dispose();
    _positionDropdownController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }

}
