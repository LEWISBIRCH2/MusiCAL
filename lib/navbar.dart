import 'package:flutter/material.dart';

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Image.asset(
              'musiCAL_LOGO.png',
              height: 300,
              width: 500,
            ),
            title: const Text('MusiCAL - NavBar'),
            //   Image.asset('assets/musiCAL_LOGO.png', height: 20),

            actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_month),
            tooltip: 'Show Calendar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Displays calendar...')));
            },
          ),
          IconButton(
              icon: const Icon(Icons.thumb_up),
              tooltip: 'Show Recommendations',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Displays recommendations...')));
              }),
          IconButton(
              icon: const Icon(Icons.star),
              tooltip: 'Show FestiCAL',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Displays FestiCAL...')));
              }),
          IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Show Settings',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Displays settings...')));
              }),
        ]));
  }
}
