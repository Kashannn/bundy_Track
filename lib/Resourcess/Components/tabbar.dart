import 'package:bundy_track/Resourcess/Components/stopwatch.dart';
import 'package:bundy_track/Resourcess/Components/widget.dart';
import 'package:flutter/material.dart';
import 'Colors.dart';
import 'digitbutton.dart';

class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              //code for manual hours log that is the first tab
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: AppColors.borderColor, // Border color
                        width: 1.0, // Border width
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
                        DigitButton(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: allButton(
                            text: 'Confirm',
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //code for time track that is the second tab
              StopwatchPage(labelText: 'Worked Today:'),

              StopwatchPage(labelText: 'Over Time:'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabContainer(String text, int index) {
    bool isSelected = _tabController.index == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _tabController.index = index;
        });
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
  }
}
