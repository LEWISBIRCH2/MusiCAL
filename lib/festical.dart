import 'package:flutter/material.dart';

class Festical extends StatelessWidget {
  const Festical({super.key});

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
            Center(
              child: Stack(
                children: [
                  Image.asset('assets/images/EmptyLineUp.jpg'),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.5, -0.5),
                          child: Text(
                            "An Band",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.6, -0.21),
                          child: Text(
                            "Another Band",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.5, 0.08),
                          child: Text(
                            "A Third Band",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.85, -0.4),
                          child: Text(
                            "Smaller Band",
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.27, -0.4),
                          child: Text(
                            "Smaller Band 2",
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.33, -0.4),
                          child: Text(
                            "Smaller Band 3",
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.92, -0.4),
                          child: Text(
                            "Smaller Band 4",
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.87, -0.31),
                          child: Text(
                            "Rly smol band",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.41, -0.31),
                          child: Text(
                            "Smol band 2",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.02, -0.31),
                          child: Text(
                            "Smol band 3",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.45, -0.31),
                          child: Text(
                            "Smol band 4",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.89, -0.31),
                          child: Text(
                            "Smol band 5",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.85, -0.11),
                          child: Text(
                            "Smaller Band",
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.27, -0.11),
                          child: Text(
                            "Smaller Band 2",
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.33, -0.11),
                          child: Text(
                            "Smaller Band 3",
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.92, -0.11),
                          child: Text(
                            "Smaller Band 4",
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.87, -0.02),
                          child: Text(
                            "Rly smol band",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.41, -0.02),
                          child: Text(
                            "Smol band 2",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.02, -0.02),
                          child: Text(
                            "Smol band 3",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.45, -0.02),
                          child: Text(
                            "Smol band 4",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.89, -0.02),
                          child: Text(
                            "Smol band 5",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.85, 0.18),
                          child: Text(
                            "Smaller Band",
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.27, 0.18),
                          child: Text(
                            "Smaller Band 2",
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.33, 0.18),
                          child: Text(
                            "Smaller Band 3",
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.92, 0.18),
                          child: Text(
                            "Smaller Band 4",
                            style: TextStyle(color: Colors.black, fontSize: 6),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.87, 0.27),
                          child: Text(
                            "Rly smol band",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(-0.41, 0.27),
                          child: Text(
                            "Smol band 2",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.02, 0.27),
                          child: Text(
                            "Smol band 3",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.45, 0.27),
                          child: Text(
                            "Smol band 4",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          ))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment(0.89, 0.27),
                          child: Text(
                            "Smol band 5",
                            style: TextStyle(color: Colors.black, fontSize: 5),
                          )))
                ],
              ),
            ),
            Center(
                child: Stack(children: [
              Image.asset('assets/images/glastonbury_poster_template.jpg'),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.7, -0.2),
                      child: Text(
                        "Some Big Band",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0, -0.29),
                      child: Text(
                        "Big Big Band",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.7, -0.2),
                      child: Text(
                        "Bigsnkajs Band",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.85, -0.05),
                      child: Text(
                        "Medium Band 1",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.3, -0.05),
                      child: Text(
                        "Medium Band 2",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.3, -0.05),
                      child: Text(
                        "Medium Band 3",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, -0.05),
                      child: Text(
                        "Medium Band 4",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.85, 0.05),
                      child: Text(
                        "Medium Band 5",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.3, 0.05),
                      child: Text(
                        "Medium Band 6",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.3, 0.05),
                      child: Text(
                        "Medium Band 7",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0.05),
                      child: Text(
                        "Medium Band 8",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.86, 0.15),
                      child: Text(
                        "Small Band 1",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.45, 0.15),
                      child: Text(
                        "Small Band 2",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.05, 0.15),
                      child: Text(
                        "Small Band 3",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.4, 0.15),
                      child: Text(
                        "Small Band 4",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0.15),
                      child: Text(
                        "Small Band 5",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.86, 0.25),
                      child: Text(
                        "Small Band 6",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.45, 0.25),
                      child: Text(
                        "Small Band 7",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.05, 0.25),
                      child: Text(
                        "Small Band 8",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.4, 0.25),
                      child: Text(
                        "Small Band 9",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0.25),
                      child: Text(
                        "Small Band 10",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
            ])),
            Container(
                color: Colors.orangeAccent,
                child: Image.asset(
                    'assets/images/leeds_reading_poster_template.jpeg'))
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