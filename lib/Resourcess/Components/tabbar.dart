import 'package:bundy_track/Resourcess/Components/stopwatch.dart';
import 'package:bundy_track/Resourcess/Components/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/TabIndexProvider.dart';
import 'Colors.dart';
import 'digitbutton.dart';

class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedValue = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      Provider.of<TabIndexProvider>(context, listen: false)
          .setIndex(_tabController.index);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _storeSelectedValue() async {
   String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(userId).set({
      'selected_hours': _selectedValue,
    }, SetOptions(merge: true));
  }

  void _onValueChanged(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabIndexProvider>(
      builder: (context, tabIndexProvider, child) {
        _tabController.index = tabIndexProvider.index;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFFF0F6FE),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTabContainer('Manual Hours Log', 0),
                    _buildTabContainer('Time Track', 1),
                    _buildTabContainer('Overtime', 2),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: AppColors.borderColor,
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'How many hours are you rostered today?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DigitButton(
                              onValueChanged: _onValueChanged,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: allButton(
                                text: 'Confirm',
                                onPressed: _storeSelectedValue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  StopwatchPage(labelText: 'Worked Today:'),
                  StopwatchPage(labelText: 'Over Time:'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabContainer(String text, int index) {
    return Consumer<TabIndexProvider>(
      builder: (context, tabIndexProvider, child) {
        bool isSelected = tabIndexProvider.index == index;
        return GestureDetector(
          onTap: () {
            tabIndexProvider.setIndex(index);
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Color(0xFFF0F6FE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}
