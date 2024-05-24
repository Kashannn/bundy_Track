import 'package:flutter/material.dart';
import '../Resourcess/Components/Colors.dart';
import '../Resourcess/Components/dropdownbutton.dart';
import '../Resourcess/Components/imagePicker.dart';
import '../Resourcess/Components/widget.dart';
import '../firestore/firebase_service.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController _departmentDropdownController = TextEditingController();
  final TextEditingController _positionDropdownController = TextEditingController();
  String _imageUrl = '';

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
      showLoadingDialog(context, "loading...");
      try {
        await _firebaseService.signUp(
          emailController.text.toString(),
          passwordController.text.toString(),
          nameController.text.toString(),
          _departmentDropdownController.text.toString(),
          _positionDropdownController.text.toString(),
          _imageUrl,
        );
        Navigator.pushNamed(context, RoutesName.signInScreen);
      } catch (e) {
        Utils utils = Utils();
        utils.flashBarErrorMessage(e.toString(), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
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
