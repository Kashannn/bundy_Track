import 'package:flutter/material.dart';
import '../Resourcess/Components/reuseableContainer.dart';

class AllocatorScreen extends StatefulWidget {
  const AllocatorScreen({Key? key}) : super(key: key);

  @override
  State<AllocatorScreen> createState() => _AllocatorScreenState();
}

class _AllocatorScreenState extends State<AllocatorScreen> {
  int _expandedIndex = -1; // -1 means no item is expanded

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ReusableContainer(),
          SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _expandedIndex = _expandedIndex == index ? -1 : index;
                    });
                  },
                  child: _expandedIndex == index
                      ? _buildExpandedItem(index)
                      : _buildListItem(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Container(
        color: const Color(0xFF005EE8),
        child: ListTile(
          trailing: Text(
            '2 Hours',
            style: TextStyle(color: Colors.white),
          ),
          title: Text(
            'Item $index',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Container(
        color: const Color(0xFF005EE8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFF1A49F2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/overtime');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF34A853),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // Border radius
                        ),
                      ),
                      child: Text('Yes', style: TextStyle(color: Colors.white)),
                    ),
                    Text(
                      'Over Time',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFEA4335),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // Border radius
                        ),
                      ),
                      child: Text('No', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
