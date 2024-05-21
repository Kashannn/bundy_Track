import 'package:flutter/material.dart';

import '../Resourcess/Components/Colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      'assets/images/stackimage1.png', // Replace with your image path
                      fit: BoxFit.cover, // Ensure the image covers the container
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/stackimage2.png', // Replace with your image path
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
                          IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              // Add drawer open functionality here
                            },
                            color: Colors.white, // Change color if needed
                          ),
                          CircleAvatar(
                            radius: 20, // Adjust size as needed
                            backgroundImage: AssetImage('assets/images/user_image.png'), // Replace with your user image path
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
                        shape: BoxShape.rectangle, // Use BoxShape.circle for circular images
                      ),
                      child: Image.asset(
                        'assets/images/Logo.png', // Replace with your logo image path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'welcome Chris',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                width:double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  shape: BoxShape.rectangle,
                ),
                child:Padding(
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
                          value: false,
                          onChanged: (bool value) {

                          },
                          activeColor: Colors.blue,
                          activeTrackColor: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
                  ),
                )

              ),
            ),

          ],
        ),
      ),
    );
  }
}
