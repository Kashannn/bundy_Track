
import 'package:bundy_track/Resourcess/Components/Colors.dart';
import 'package:flutter/material.dart';

Widget allTextField({
  required String hintText,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  bool readOnly = false,
  TextEditingController? controller,
  String? Function(String?)? validator,

}) {
  return TextFormField(
    decoration: InputDecoration(
      filled: true,
      fillColor: AppColors.textFieldColor,
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 16,
        fontFamily: 'Poppins',
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Colors.grey.shade400,
        ),
      ),
    ),
    keyboardType: keyboardType,
    obscureText: obscureText,
    controller: controller,
    validator: validator,
  );
}


Widget allText({
  required String text,
}) {
  return Text(
    text,
    style: const TextStyle(
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
  return SizedBox(
    width: double.infinity, // This makes the button span the entire width of the screen
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonColor,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: const Size(double.infinity, 50), // Set the desired width and height here
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Poppins',
          color: Colors.white,
        ),
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
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      color: AppColors.textFieldColor,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        dropdownColor: AppColors.textFieldColor,
        icon: const Icon(Icons.arrow_drop_down),
      ),
    ),
  );
}


void showLoadingDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false, // prevent dismissing dialog on tap outside
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text(text),
          ],
        ),
      );
    },
  );
}




