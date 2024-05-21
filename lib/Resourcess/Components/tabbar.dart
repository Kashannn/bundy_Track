import 'package:flutter/material.dart';

import 'Colors.dart';

class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> with SingleTickerProviderStateMixin {
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
        Container(
          decoration: BoxDecoration(
            color: AppColors.tabBarColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TabBar(
            controller: _tabController,
            onTap: (index) {
              setState(() {});
            },
            tabs: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: _tabController.index == 0 ? Colors.white : AppColors.tabBarColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Tab(
                    child: Text(
                      'Manual Hours Log',
                      style: TextStyle(
                        color: _tabController.index == 0 ? AppColors.primaryColor : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: _tabController.index == 1 ? Colors.white : AppColors.tabBarColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Tab(
                  child: Text(
                    'Time Track',
                    style: TextStyle(
                      color: _tabController.index == 1 ? AppColors.primaryColor : Colors.grey,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: _tabController.index == 2 ? Colors.white : AppColors.tabBarColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Tab(
                  child: Text(
                    'Overtime',
                    style: TextStyle(
                      color: _tabController.index == 2 ? AppColors.primaryColor : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Center(child: Text('Manual Hours Log')),
              Center(child: Text('Time Track')),
              Center(child: Text('Overtime')),
            ],
          ),
        ),
      ],
    );
  }
}
