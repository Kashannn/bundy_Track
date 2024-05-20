import 'package:bundy_track/Resourcess/Components/Colors.dart';
import 'package:bundy_track/Resourcess/Components/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: AppColors.container,
                  height: height * 0.3,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/Logo.png'),
                      SizedBox(
                          height: height *
                              0.03), // Add space between image and text
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: AppColors.container,
                height: height * 0.5,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    allText(text: 'Email'),
                    SizedBox(height: height * 0.01),
                    allTextField(hintText: 'Email'),
                    SizedBox(height: height * 0.01),
                    allText(text: 'Password'),
                    SizedBox(height: height * 0.01),
                    allTextField(hintText: 'Password'),
                    SizedBox(height: height * 0.03),
                    allButton(
                      text: 'Login',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
