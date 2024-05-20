import 'package:bundy_track/Resourcess/Components/Colors.dart';
import 'package:flutter/material.dart';

Widget allTextField({
  required String hintText,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  TextEditingController? controller,
}) {
  return TextField(
    decoration: InputDecoration(
      filled: true,
      fillColor: AppColors.textFieldColor,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: 16,
        fontFamily: 'Poppins',
      ),
      border: InputBorder.none,
    ),
    keyboardType: keyboardType,
    obscureText: obscureText,
    controller: controller,
  );
}

Widget allText({
  required String text,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 16,
      fontFamily: 'Poppins',
      color: AppColors.textColor,
    ),
  );
}


Widget allButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontFamily: 'Poppins',
        color: Colors.white,
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.buttonColor,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      minimumSize: Size(300, 50), // Set the desired width and height here
    ),
  );
}
