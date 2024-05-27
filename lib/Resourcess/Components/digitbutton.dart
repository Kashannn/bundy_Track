import 'package:flutter/material.dart';

import 'Colors.dart';

class DigitButton extends StatefulWidget {
  final ValueChanged<int> onValueChanged;

  DigitButton({required this.onValueChanged});

  @override
  _DigitButtonState createState() => _DigitButtonState();
}

class _DigitButtonState extends State<DigitButton> {
  int digit = 0;

  void _incrementDigit() {
    setState(() {
      digit++;
      widget.onValueChanged(digit);
    });
  }

  void _decrementDigit() {
    setState(() {
      if (digit > 0) {
        digit--;
        widget.onValueChanged(digit);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(),
        child: Row(
          children: [
            Expanded(
              child: Container(
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
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.borderColor),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    '$digit Hours',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
