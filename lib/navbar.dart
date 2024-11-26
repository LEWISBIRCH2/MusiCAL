import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Image.asset(
              'musiCAL_LOGO.png',
              height: 300,
              width: 500,
            ),
            title: const Text('musiCAL - NavBar'),
            //   Image.asset('assets/musiCAL_LOGO.png', height: 20),

            actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_month_rounded),
            tooltip: 'Show Calendar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Displays calendar...')));
            },
          ),
          IconButton(
              icon: const Icon(Icons.thumb_up_off_alt_rounded),
              tooltip: 'Show Recommendations',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Displays recommendations...')));
              }),
          IconButton(
              icon: const Icon(Icons.festival),
              tooltip: 'Show FestiCAL',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Displays FestiCAL...')));
              }),
          IconButton(
              icon: const Icon(Icons.settings_rounded),
              tooltip: 'Show Settings',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Displays settings...')));
              }),
        ]));
  }
}
