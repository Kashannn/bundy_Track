import 'package:bundy_track/provider/Welcome_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Resourcess/Components/reuseableContainer.dart';
import '../utils/routes/routes_name.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: ReusableContainer(
                name: userProvider.userName,
                circularImageUrl: userProvider.userImageUrl,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Add your onTap logic here
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          tileColor: Color(0xFF0063F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              width: 2,
                            ),
                          ),
                          title: Text(
                            'Allocator $index',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          trailing: Text(
                            '2 Hours',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                          )),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
