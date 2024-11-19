import 'package:flutter/material.dart';

class Festical extends StatelessWidget {
  const Festical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.filter_1_rounded),
                ),
                Tab(
                  icon: Icon(Icons.filter_2_rounded),
                ),
                Tab(
                  icon: Icon(Icons.filter_3_rounded),
                )
              ],
            ),
            title: const Text('Your Festical'),
          ),
          body: TabBarView(children: [
            Container(
                color: Colors.orangeAccent,
                child: const Icon(Icons.filter_1_rounded)),
            Container(
                color: Colors.redAccent,
                child: const Icon(Icons.filter_2_rounded)),
            Container(
                color: Colors.orangeAccent,
                child: const Icon(Icons.filter_3_rounded))
          ]),
        ));
  }
}

// class Festical extends StatefulWidget {
//   const Festical({super.key});

//   @override
//   _FesticalState createState() => _FesticalState();
// }

// class _FesticalState extends State<Festical> {
//   int _selectedIndex = 0;

//   final List<Widget> _widgetOptions = [

//   ]

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('Your Festical'), actions: [
//           IconButton(
//             icon: const Icon(Icons.filter_1_rounded),
//             tooltip: 'Design 1',
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.filter_2_rounded),
//             tooltip: 'Design 2',
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.filter_3_rounded),
//             tooltip: 'Design 3',
//             onPressed: () {},
//           )
//         ]),
//         body: Center(
//           child: Image(image: AssetImage('assets/images/EmptyLineUp.jpg')),
//         ));
//   }
// }
