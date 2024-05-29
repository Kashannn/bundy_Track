import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Resourcess/Components/Colors.dart';
import '../Resourcess/Components/widget.dart';
import '../provider/Welcome_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                          backgroundColor: AppColors.container,
                          backgroundImage: NetworkImage(
                            userProvider.userImageUrl,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {},
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
                  Text(
                    '${userProvider.userName}',
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
                  Text(
                    '${userProvider.department}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    allText(text: 'Name'),
                    allTextField(
                      hintText: '${userProvider.userName}',
                    ),
                    allText(text: 'Email'),
                    allTextField(hintText: '${userProvider.email}'),
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
            ],
          ),
        ),
      ),
    );
  }
}
