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
              Image.asset('/images/glastonbury_poster_template.jpg'),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.7, -0.15),
                      child: Text(
                        "Some Big Band",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0, -0.27),
                      child: Text(
                        "Big Big Band",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.7, -0.15),
                      child: Text(
                        "Bigsnkajs Band",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.85, 0),
                      child: Text(
                        "Medium Band 1",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.3, 0),
                      child: Text(
                        "Medium Band 2",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.3, 0),
                      child: Text(
                        "Medium Band 3",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0),
                      child: Text(
                        "Medium Band 4",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.85, 0.12),
                      child: Text(
                        "Medium Band 5",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.3, 0.12),
                      child: Text(
                        "Medium Band 6",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.3, 0.12),
                      child: Text(
                        "Medium Band 7",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0.12),
                      child: Text(
                        "Medium Band 8",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.85, 0.25),
                      child: Text(
                        "Medium Band 9",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.3, 0.25),
                      child: Text(
                        "Medium Band 10",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.3, 0.25),
                      child: Text(
                        "Medium Band 11",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0.25),
                      child: Text(
                        "Medium Band 12",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.86, 0.4),
                      child: Text(
                        "Small Band 1",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.45, 0.4),
                      child: Text(
                        "Small Band 2",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.05, 0.4),
                      child: Text(
                        "Small Band 3",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.4, 0.4),
                      child: Text(
                        "Small Band 4",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0.4),
                      child: Text(
                        "Small Band 5",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.86, 0.55),
                      child: Text(
                        "Small Band 6",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.45, 0.55),
                      child: Text(
                        "Small Band 7",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.05, 0.55),
                      child: Text(
                        "Small Band 8",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.4, 0.55),
                      child: Text(
                        "Small Band 9",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0.55),
                      child: Text(
                        "Small Band 10",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.86, 0.7),
                      child: Text(
                        "Small Band 11",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.45, 0.7),
                      child: Text(
                        "Small Band 12",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.05, 0.7),
                      child: Text(
                        "Small Band 13",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.4, 0.7),
                      child: Text(
                        "Small Band 14",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, 0.7),
                      child: Text(
                        "Small Band 15",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ))),
            ])),
            Center(
                child: Stack(children: [
              Image.asset('assets/images/leeds_final.jpg'),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.5, -0.8),
                      child: Text(
                        "Headliner 2",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.2, -0.95),
                      child: Text(
                        "Headliner 1",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.85, -0.8),
                      child: Text(
                        "Headliner 3",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.57, -0.5),
                      child: Text(
                        "Medium 1",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.1, -0.5),
                      child: Text(
                        "Medium 2",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.4, -0.5),
                      child: Text(
                        "Medium 3",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.88, -0.5),
                      child: Text(
                        "Medium 4",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.57, -0.3),
                      child: Text(
                        "Medium 5",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.1, -0.3),
                      child: Text(
                        "Medium 6",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.4, -0.3),
                      child: Text(
                        "Medium 7",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.88, -0.3),
                      child: Text(
                        "Medium 8",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.57, -0.1),
                      child: Text(
                        "Medium 9",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.1, -0.1),
                      child: Text(
                        "Medium 10",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.4, -0.1),
                      child: Text(
                        "Medium 11",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.88, -0.1),
                      child: Text(
                        "Medium 12",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.6, 0.1),
                      child: Text(
                        "Small 1",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.25, 0.1),
                      child: Text(
                        "Small 2",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.15, 0.1),
                      child: Text(
                        "Small 3",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.55, 0.1),
                      child: Text(
                        "Small 4",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.88, 0.1),
                      child: Text(
                        "Small 5",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.6, 0.3),
                      child: Text(
                        "Small 6",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.25, 0.3),
                      child: Text(
                        "Small 7",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.15, 0.3),
                      child: Text(
                        "Small 8",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.55, 0.3),
                      child: Text(
                        "Small 9",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.88, 0.3),
                      child: Text(
                        "Small 10",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.6, 0.5),
                      child: Text(
                        "Small 11",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(-0.25, 0.5),
                      child: Text(
                        "Small 12",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.15, 0.5),
                      child: Text(
                        "Small 13",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.55, 0.5),
                      child: Text(
                        "Small 14",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.88, 0.5),
                      child: Text(
                        "Small 15",
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ))),
            ]))
          ]),
        ));
  }
}
