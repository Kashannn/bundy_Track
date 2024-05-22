import 'package:flutter/material.dart';

import '../Resourcess/Components/imagePicker.dart';
import '../Resourcess/Components/widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/Logo.png'),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: CircleAvatar(
                              radius:
                                  15, // Adjust the size of the edit icon as needed
                              backgroundColor:
                                  Colors.white, // Optional: background color
                              child: Image.asset(
                                'assets/images/Editphoto.png', // Path to your edit icon
                                height:
                                    20, // Adjust the size of the edit icon as needed
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Kashan Ashraf',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Flutter Developer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              allText(text: 'Name'),
              allTextField(hintText: 'Name'),
              allText(text: 'Email'),
              allTextField(hintText: 'Email'),
              allText(text: 'Password'),
              allTextField(hintText: 'Password'),
              allText(text: 'Department'),
              allDropdownButton(
                items: ['Department', 'Finance', 'Marketing'],
                value: 'Department',
                onChanged: (String? value) {},
              ),
              allText(text: 'Position'),
              allDropdownButton(
                items: ['Position', 'Finance', 'Marketing'],
                value: 'Position',
                onChanged: (String? value) {},
              ),
              allButton(
                text: 'Save',
                onPressed: () {
                  Navigator.pushNamed(context, '/Allocator');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
