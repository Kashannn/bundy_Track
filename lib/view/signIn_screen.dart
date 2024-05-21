import 'package:bundy_track/Resourcess/Components/Colors.dart';
import 'package:bundy_track/Resourcess/Components/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/routes/routes_name.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                  color: AppColors.container,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      allText(text: 'Email'),
                      SizedBox(height: height * 0.02),
                      allTextField(hintText: 'Email'),
                      SizedBox(height: height * 0.02),
                      allText(text: 'Password'),
                      SizedBox(height: height * 0.02),
                      allTextField(hintText: 'Password'),
                      SizedBox(height: height * 0.03),
                      allButton(
                        text: 'Sign In',
                        onPressed: () {},
                      ),
                      SizedBox(height: height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: AppColors.textColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RoutesName.signUpScreen);
                            },
                            child: Text(
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
    );
  }
}
