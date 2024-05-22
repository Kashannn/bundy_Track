import 'package:flutter/material.dart';

import 'Colors.dart';

class DigitButton extends StatefulWidget {
  @override
  _DigitButtonState createState() => _DigitButtonState();
}

class _DigitButtonState extends State<DigitButton> {
  int digit = 0;

  void _incrementDigit() {
    setState(() {
      digit++;
    });
  }

  void _decrementDigit() {
    setState(() {
      if (digit > 0) {
        digit--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      decoration: BoxDecoration(

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.iconColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_left, color: Colors.white),
              onPressed: _decrementDigit,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(
                vertical: BorderSide(color: Colors.grey),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '$digit Hours',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.iconColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_right, color: Colors.white),
              onPressed: _incrementDigit,
            ),
          ),
        ],
      ),
    );
  }
}
