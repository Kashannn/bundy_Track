import 'package:flutter/material.dart';
import '../Resourcess/Components/reuseableContainer.dart';

class AllocatorScreen extends StatefulWidget {
  const AllocatorScreen({Key? key}) : super(key: key);

  @override
  State<AllocatorScreen> createState() => _AllocatorScreenState();
}

class _AllocatorScreenState extends State<AllocatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ReusableContainer(),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Replace 10 with your actual item count
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
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
