import 'package:flutter/material.dart';
import 'login.dart';
import 'settings.dart';

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
                  icon: Icon(Icons.home),
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
            title: const Text('flutter map'),
          ),
          body: TabBarView(
            children: [
              Container(
                color: Colors.orangeAccent,
                child: const Icon(Icons.home),
              ),
              Login(),
              Container(
                color: Colors.orangeAccent,
                child: const Icon(Icons.person),
              ),
              Settings(),
            ],
          )),
    );
  }
}
