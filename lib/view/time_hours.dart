import 'package:bundy_track/Resourcess/Components/tabbar.dart';
import 'package:flutter/material.dart';

import '../Resourcess/Components/Colors.dart';

class TimeHours extends StatefulWidget {
  const TimeHours({super.key});

  @override
  State<TimeHours> createState() => _TimeHoursState();
}

class _TimeHoursState extends State<TimeHours> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                        fit: BoxFit
                            .cover, // Ensure the image covers the container
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
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () {
                                    // Add back button functionality here
                                  },
                                  color: Colors.white, // Change color if needed
                                ),
                                SizedBox(
                                    width:
                                        8), // Add space between icon and text
                                Text(
                                  'Kashan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              radius: 20, // Adjust size as needed
                              backgroundImage:
                                  const AssetImage('assets/images/profile.png'),
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
                          shape: BoxShape
                              .rectangle, // Use BoxShape.circle for circular images
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
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Switch(
                            value: true,
                            onChanged: (bool value) {
                              // Add switch functionality here
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
              SizedBox(height: 20),
              Expanded(child: CustomTabBar()),
            ],
          ),
        ),
      ),
    );
  }
}
