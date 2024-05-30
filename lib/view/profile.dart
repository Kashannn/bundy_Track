import 'package:bundy_track/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Resourcess/Components/Colors.dart';
import '../Resourcess/Components/imagePicker.dart';
import '../Resourcess/Components/widget.dart';
import '../provider/Welcome_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late UserProvider userProvider;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final List<String> positions = ['Position', 'Finance', 'Marketing'];

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    nameController.text = userProvider.userName;
    departmentController.text = userProvider.department;
    positionController.text = userProvider.position;
    emailController.text = userProvider.email;
  }

  void _updateUserImage(String imageUrl) {
    setState(() {
      userProvider.userImageUrl = imageUrl;
    });
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
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ImagePickerWidget(
                                    onImagePicked: _updateUserImage,
                                  );
                                },
                              );
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Image.asset(
                                'assets/images/Editphoto.png',
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                    '${userProvider.position}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    allText(text: 'Name'),
                    allTextField(
                      hintText: 'Name',
                      controller: nameController,
                    ),
                    allText(text: 'Email'),
                    allTextField(
                      hintText: 'Email',
                      controller: emailController,
                      readOnly: true,
                    ),
                    allText(text: 'Password'),
                    allTextField(
                      hintText: 'Password',
                      controller: passwordController,
                      obscureText: true,
                    ),
                    allText(text: 'Position'),
                    allDropdownButton(
                      items: positions,
                      value: positions.contains(userProvider.position)
                          ? userProvider.position
                          : positions[0],
                      onChanged: (String? value) {
                        setState(() {
                          positionController.text = value!;
                          userProvider.position = value;
                        });
                      },
                    ),
                    allButton(
                      text: 'Save',
                      onPressed: () async {
                        bool success = await updateUserRecord(
                          userProvider.getCurrentUser()!.uid,
                          nameController.text,
                          departmentController.text,
                          positionController.text,
                          userProvider.userImageUrl,
                        );
                        if (success) {
                          userProvider.updateUserData(
                            nameController.text,
                            departmentController.text,
                            positionController.text,
                            userProvider.userImageUrl,
                          );
                          Utils.toastMessage('Profile updated successfully');
                          Navigator.pop(context);
                        }
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
