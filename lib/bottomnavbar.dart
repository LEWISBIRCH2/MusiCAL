import 'package:flutter/material.dart';
import 'calendar.dart';
import 'recommendations.dart';
import 'settings.dart';
import 'festical.dart';

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
        iconSize: 35,
        showSelectedLabels: false,
        showUnselectedLabels: false,
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
