import 'dart:async';
import 'package:flutter/material.dart';

class PianoLoading extends StatefulWidget {
  @override
  _PianoLoadingState createState() => _PianoLoadingState();
}

class _PianoLoadingState extends State<PianoLoading> {
  final int numberOfKeys = 14;
  int activeKeyIndex = 0;
  double textOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 330), (timer) {
      if (mounted) {
        setState(() {
          activeKeyIndex = (activeKeyIndex + 1) % (numberOfKeys * 2);
        });
      }
    });

    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (mounted) {
        setState(() {
          textOpacity = textOpacity == 1.0 ? 0.0 : 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width * 0.9;
    final double horizontalPadding = 16.0;
    final double totalPaddedWidth = screenWidth - (horizontalPadding * 2);
    final double whiteKeyWidth = totalPaddedWidth / numberOfKeys;
    final double blackKeyWidth = whiteKeyWidth * 0.6;
    final double whiteKeyHeight = 150;
    final double blackKeyHeight = 90;
    final List<int> blackKeyPositions = [0, 1, 3, 4, 5, 7, 8, 10, 11, 12];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: totalPaddedWidth,
                height: whiteKeyHeight,
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(numberOfKeys, (index) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 150),
                          margin: EdgeInsets.symmetric(horizontal: 0.5),
                          width: whiteKeyWidth - 1,
                          height: whiteKeyHeight,
                          decoration: BoxDecoration(
                            color: activeKeyIndex == index * 2
                                ? Color.fromARGB(255, 57, 191, 5)
                                    .withOpacity(0.95)
                                : Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    Positioned.fill(
                      child: Stack(
                        children: List.generate(numberOfKeys - 1, (index) {
                          if (!blackKeyPositions.contains(index)) {
                            return SizedBox.shrink();
                          }
                          return Positioned(
                            left:
                                (index + 1) * whiteKeyWidth - blackKeyWidth / 2,
                            top: 0,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 150),
                              width: blackKeyWidth,
                              height: blackKeyHeight,
                              decoration: BoxDecoration(
                                color: activeKeyIndex == index * 2 + 1
                                    ? Color.fromARGB(255, 57, 191, 5)
                                        .withOpacity(0.95)
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              AnimatedOpacity(
                duration: Duration(milliseconds: 1000),
                opacity: textOpacity,
                child: Text(
                  'building your calendar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
