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
        title: Text('Bottom Nav Bar'),
      ),
      body: IndexedStack(children: [
        Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month,
                  color: const Color.fromARGB(255, 0, 0, 0)),
              label: 'Page 1'),
          BottomNavigationBarItem(
              icon: Icon(Icons.recommend_rounded,
                  color: const Color.fromARGB(255, 0, 0, 0)),
              label: 'Page 2'),
          BottomNavigationBarItem(
              icon: Icon(Icons.festival_rounded,
                  color: const Color.fromARGB(255, 0, 0, 0)),
              label: 'Page 3'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded,
                  color: const Color.fromARGB(255, 0, 0, 0)),
              label: 'Page 4'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
