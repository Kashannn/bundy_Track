import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Resourcess/Components/Colors.dart';
import '../provider/Welcome_provider.dart';
import '../utils/routes/routes_name.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    height: 313,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/stackimage1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            'assets/images/stackimage2.png',
                            width: double.infinity,
                            height: 313,
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PopupMenuButton<String>(
                                  icon: const Icon(Icons.menu),
                                  onSelected: (String result) {
                                    switch (result) {
                                      case 'Profile':
                                        Navigator.pushNamed(
                                            context, RoutesName.profile);
                                        break;
                                      case 'TimeHours':
                                        Navigator.pushNamed(
                                            context, RoutesName.allocator);
                                        break;
                                      case 'Logout':
                                        userProvider.signOut(context);
                                    }
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
                                    const PopupMenuItem<String>(
                                      value: 'Profile',
                                      child: ListTile(
                                        leading: Icon(Icons.person),
                                        title: Text('Profile'),
                                      ),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'TimeHours',
                                      child: ListTile(
                                        leading: Icon(Icons.timer),
                                        title: Text('TimeHours Request'),
                                      ),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'Logout',
                                      child: ListTile(
                                        leading: Icon(Icons.logout),
                                        title: Text('Logout'),
                                      ),
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: AppColors.container,
                                  backgroundImage: userProvider
                                          .userImageUrl.isNotEmpty
                                      ? NetworkImage(userProvider.userImageUrl)
                                      : null,
                                  child: userProvider.userImageUrl.isEmpty
                                      ? Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                            child: Image.asset(
                              'assets/images/Logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'welcome ${userProvider.userName}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bundy ON',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Poppins',
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Switch(
                                value: userProvider.isSwitched,
                                onChanged: (bool value) {
                                  userProvider.toggleSwitch(value);
                                  if (value) {
                                    Navigator.pushNamed(
                                        context, RoutesName.timeHours);
                                  }
                                },
                                activeColor: Colors.blue,
                                activeTrackColor: Colors.lightBlueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
