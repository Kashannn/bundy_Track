import 'package:bundy_track/Resourcess/Components/Colors.dart';
import 'package:flutter/material.dart';

class DropButton extends StatefulWidget {
  final TextEditingController controller;
  DropButton({required this.controller});
  @override
  State<DropButton> createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {

  String _selectedValue = 'HR';

  @override
  void initState() {
    super.initState();
    widget.controller.text = _selectedValue;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.textFieldColor,
          child: DropdownButton<String>(
            value: _selectedValue,
            items: ['HR', 'Finance', 'Marketing',].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedValue = newValue!;
                widget.controller.text = _selectedValue;

              });
            },

            dropdownColor: AppColors.textFieldColor,
            icon: const Icon(Icons.arrow_drop_down),
          ),
        ),
      ],
    );
  }
}
