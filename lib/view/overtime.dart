import 'package:bundy_track/Resourcess/Components/reuseableContainer.dart';
import 'package:bundy_track/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class Overtime extends StatefulWidget {
  const Overtime({super.key});

  @override
  State<Overtime> createState() => _OvertimeState();
}

class _OvertimeState extends State<Overtime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ReusableContainer(),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Number of items in the list
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: Container(
                    color: const Color(0xFF34A853),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/selectionScreen');
                      },
                      child: ListTile(
                          title: Center(
                            child: Text(
                              'Kashan Ashraf',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 23,
                              ),
                            ),
                          ),
                          subtitle: Center(
                            child: Text(
                              'Over time',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 18,
                              ),
                            ),
                          )),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}