import 'dart:io';

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
  return Container(
    width: double.infinity, // This makes the button span the entire width of the screen
    child: ElevatedButton(
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
        minimumSize: Size(double.infinity, 50), // Set the desired width and height here
      ),
    ),
  );
}



Widget allDropdownButton({
  required List<String> items,
  required String value,
  required void Function(String?) onChanged,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      color: AppColors.textFieldColor, // Use the same background color as the TextField

    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                color: Colors.black, // Set the text color here
                fontSize: 16,
                fontFamily: 'Poppins', // Use the same font as the TextField hint
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        dropdownColor: AppColors.textFieldColor, // Set the dropdown menu background color
      ),
    ),
  );
}




