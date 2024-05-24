import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Resourcess/Components/Colors.dart';
import '../Resourcess/Components/dropdownbutton.dart';
import '../Resourcess/Components/imagePicker.dart';
import '../Resourcess/Components/widget.dart';
import '../utils/routes/routes_name.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection('users');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController _departmentDropdownController = TextEditingController();
  final TextEditingController _positionDropdownController = TextEditingController();

  String _imageUrl = ''; // Add a state variable to store the image URL

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    _departmentDropdownController.dispose();
    _positionDropdownController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        print('Attempting to create a new user...');
        await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        print('User created successfully');
        await storeData(); // Call storeData after successful sign-up
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          // Try to sign in with the existing email and password
          try {
            print('Attempting to sign in with existing account...');
            await auth.signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
            print('Sign-in successful');
            await storeData(); // Call storeData after successful sign-in
          } catch (signInError) {
            print('Sign-in failed: $signInError');
          }
        }
      } catch (e) {
        print('Sign-up failed: $e');
      }
    }
  }

  // Store user data in Firestore
  Future<void> storeData() async {
    if (auth.currentUser != null) {
      String id = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      await fireStore.doc(auth.currentUser!.uid).set({
        'Name': nameController.text.toString(),
        'Email': emailController.text.toString(),
        'Department': _departmentDropdownController.text.toString(),
        'Position': _positionDropdownController.text.toString(),
        'id': id,
        'Password': passwordController.text.toString(),
        'ImageURL': _imageUrl,
      }).then((value) {
        print('Data stored');
      }).catchError((error) {
        print('Error: $error');
      });
    } else {
      print('No user is signed in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: AppColors.container,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/Logo.png'),
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        allText(text: 'add profile photo'),
                        ImagePickerWidget(
                          onImagePicked: (String imageUrl) {
                            setState(() {
                              _imageUrl = imageUrl;
                            });
                          },
                        ),
                        allText(text: 'Name'),
                        allTextField(
                          hintText: 'Name',
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Name';
                            }
                          },
                        ),
                        allText(text: 'Email'),
                        allTextField(
                          hintText: 'Email',
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(
                                value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        allText(text: 'Password'),
                        allTextField(
                          hintText: 'Password',
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                        allText(text: 'Department'),
                        DropButton(controller: _departmentDropdownController),
                        allText(text: 'Position'),
                        DropButton(controller: _positionDropdownController),
                        SizedBox(height: 20),
                        allButton(
                          text: 'Sign Up',
                          onPressed: () {
                            _signUp();
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: AppColors.textColor,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RoutesName.signInScreen);
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  color: AppColors.buttonColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
