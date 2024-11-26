import 'package:flutter/material.dart';
import 'login.dart';
import 'settings.dart';
import 'package:musical/main.dart';

class Navbar2 extends StatelessWidget {
  const Navbar2({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.calendar_month),
                ),
                Tab(
                  icon: Icon(Icons.settings),
                ),
                Tab(
                  icon: Icon(Icons.person),
                ),
                Tab(
                  icon: Icon(Icons.star),
                ),
              ],
            ),
            title: const Text('MusiCAL'),
            leading: Image.asset(
              'musiCAL_LOGO.png',
              height: 400,
              width: 600,
            ),
          ),
          body: TabBarView(
            children: [
              Calendar(),
              Login(),
              Container(
                color: Colors.orangeAccent,
                child: const Icon(Icons.person),
              ),
              Settings(),
              Recommendations(),
              Container(
                color: Colors.redAccent,
                child: const Icon(Icons.star),
              ),
            ],
          )),
    );
  }
}
