import 'package:flutter/material.dart';
import 'recommendations.dart';
import 'settings.dart';
import 'package:musical/main.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    Calendar(),
    Recommendations(),
    Festical(),
    Settings()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MusiCAL'),
      ),
      body: IndexedStack(children: [
        Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 10),
        selectedItemColor: Colors.black,
        unselectedLabelStyle:
            const TextStyle(color: Colors.black, fontSize: 10),
        unselectedItemColor: Colors.black,
        iconSize: 35,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month,
                  color: const Color.fromARGB(255, 0, 0, 0)),
              label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.recommend_rounded,
                  color: const Color.fromARGB(255, 0, 0, 0)),
              label: 'Recommendations'),
          BottomNavigationBarItem(
              icon: Icon(Icons.festival_rounded,
                  color: const Color.fromARGB(255, 0, 0, 0)),
              label: 'Festical'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded,
                  color: const Color.fromARGB(255, 0, 0, 0)),
              label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
