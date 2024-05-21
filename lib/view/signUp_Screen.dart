import 'package:flutter/material.dart';

import '../Resourcess/Components/Colors.dart';
import '../Resourcess/Components/imagePicker.dart';
import '../Resourcess/Components/widget.dart';
import '../utils/routes/routes_name.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: AppColors.container,
                height: height * 0.3,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/Logo.png'),
                    Text(
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
                child: Container(
                  color: AppColors.container,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Aligns children in the center vertically
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the start horizontally
                    children: [
                      allText(text: 'add profile photo'),
                      SizedBox(height: height * 0.02),
                      ImagePickerWidget(),
                      allText(text: 'Name'),
                      SizedBox(height: height * 0.02),
                      allTextField(hintText: 'Name'),
                      SizedBox(height: height * 0.02),
                      allText(text: 'Email'),
                      SizedBox(height: height * 0.02),
                      allTextField(hintText: 'Email'),
                      SizedBox(height: height * 0.02),
                      allText(text: 'Password'),
                      SizedBox(height: height * 0.02),
                      allTextField(hintText: 'Password'),
                      SizedBox(height: height * 0.03),
                      allText(text: 'Department'),
                      SizedBox(height: height * 0.02),
                      allDropdownButton(
                        items: ['HR', 'Finance', 'Marketing'],
                        value: 'HR',
                        onChanged: (String? value) {},

                      ),
                      allText(text: 'Position'),
                      SizedBox(height: height * 0.02),
                      allDropdownButton(
                        items: ['HR', 'Finance', 'Marketing'],
                        value: 'HR',
                        onChanged: (String? value) {},

                      ),
                      SizedBox(height: height * 0.02),
                      allButton(
                        text: 'Sign Up',
                        onPressed: () {},
                      ),
                      SizedBox(height: height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: AppColors.textColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RoutesName.signInScreen);
                            },
                            child: Text(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
