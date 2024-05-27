import 'package:bundy_track/Resourcess/Components/tabbar.dart';
import 'package:bundy_track/provider/Welcome_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Resourcess/Components/Colors.dart';
import '../Resourcess/Components/reuseableContainer.dart';
import 'package:provider/provider.dart';

class TimeHours extends StatefulWidget {
  const TimeHours({Key? key}) : super(key: key);

  @override
  State<TimeHours> createState() => _TimeHoursState();
}

class _TimeHoursState extends State<TimeHours> {
  late UserProvider userProvider;
  late bool isSwitched;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    isSwitched = userProvider.isSwitched;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              ReusableContainer(
                name: userProvider.userName,
                circularImageUrl: userProvider.userImageUrl,
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
                            value: isSwitched,
                            onChanged: (bool value) {
                              setState(() {
                                isSwitched = value;
                                userProvider.toggleSwitch(value);
                                if (!isSwitched) {
                                  // Navigate back to WelcomeScreen
                                  Navigator.pop(context);
                                }
                              });
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
              SizedBox(height: 15),
              Expanded(child: CustomTabBar()),
            ],
          ),
        ),
      ),
    );
  }
}
