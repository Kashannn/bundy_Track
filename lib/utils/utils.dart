
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {


  static fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }



  toastMessage(String message){
    Fluttertoast.showToast(msg:message);
  }

  dynamic  flashBarErrorMessage(String message, BuildContext context) {
    Flushbar(
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(10),
      icon: Icon(
        Icons.error_outline,
        size: 28,
        color: Colors.white,
      ),
      leftBarIndicatorColor: Colors.red,
      boxShadows: [
        BoxShadow(
          color: Colors.red.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 3,
          offset: Offset(0, 2),
        ),
      ],
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      titleText: Text(
        "Message",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    )..show(context);
  }
}