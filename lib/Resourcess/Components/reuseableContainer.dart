import 'package:flutter/material.dart';

import 'Colors.dart';

class ReusableContainer extends StatelessWidget {
  final String name;
  final String circularImageUrl;

  ReusableContainer({
    Key? key,
    required this.name,
    required this.circularImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        width: 8, // Add space between icon and text
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.container,
                    backgroundImage: circularImageUrl.isNotEmpty
                        ? NetworkImage(circularImageUrl)
                        : null,
                    child: circularImageUrl.isEmpty
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
    );
  }
}
