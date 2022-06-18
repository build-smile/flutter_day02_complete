import 'package:flutter/material.dart';

import 'Fetch.dart';
import 'info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> pages = [InfoScreen(), FetchScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day2'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://cdn.britannica.com/49/161649-050-3F458ECF/Bernese-mountain-dog-grass.jpg?q=60'),
                  ),
                  Text(
                    'Flutter day02',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Info'),
              selected: selectedIndex == 0,
              onTap: () {
                _selectedIndex(0);
              },
            ),
            ListTile(
              title: Text('Fetch data'),
              selected: selectedIndex == 1,
              onTap: () {
                _selectedIndex(1);
              },
            )
          ],
        ),
      ),
      body: pages[selectedIndex],
    );
  }

  _selectedIndex(int index) {
    selectedIndex = index;
    setState(() {});
    Navigator.pop(context);
  }
}
