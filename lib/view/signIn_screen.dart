import 'package:bundy_track/Resourcess/Components/Colors.dart';
import 'package:bundy_track/Resourcess/Components/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/Welcome_provider.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Utils utils = Utils();

  void _hideLoadingDialog() {
    Navigator.of(context).pop();
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      showLoadingDialog(context, "Signing in..."); // Show loading indicator

      try {
        await auth
            .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        )
            .then((value) async {
          _hideLoadingDialog();
          Provider.of<UserProvider>(context, listen: false).fetchUserData();

          var userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(value.user!.uid)
              .get();

          if (userDoc.exists) {
            String role = userDoc.data()!['role'];

            if (role == 'Employer') {
              Navigator.pushNamed(context, RoutesName.home);
            } else if (role == 'Employee') {
              Navigator.pushNamed(context, RoutesName.welcomeScreen);
            }
          }
        }).onError((error, stackTrace) {
          _hideLoadingDialog(); // Hide loading indicator
          utils.flashBarErrorMessage(
              "You have no account, please sign up first", context);
        });
      } on FirebaseAuthException catch (e) {
        _hideLoadingDialog(); // Hide loading indicator
        utils.flashBarErrorMessage(e.message.toString(), context);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 20, top: 20),
                  color: AppColors.container,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/Logo.png'),
                      const Text(
                        'Sign In',
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
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20, top: 20),
                    color: AppColors.container,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        allText(text: 'Email'),
                        allTextField(
                          hintText: 'Email',
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
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
                        SizedBox(height: 10),
                        allButton(
                          text: 'Sign In',
                          onPressed: _signIn,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: AppColors.textColor,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RoutesName.signUpScreen);
                              },
                              child: const Text(
                                'Sign Up',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
