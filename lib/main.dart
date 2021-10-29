import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jump_mounish/mouni.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double yAxis = 0;
  double score = 0;
  double height = 0;
  double inHeight = yAxis;
  bool gameInSession = false;
  double x1 = 0.2;
  double x2 = 0.2;
  double x3 = 1;
  double x4 = 1;

  void tap() {
    setState(() {
      score = 0;
      inHeight = yAxis;
    });
  }

  void initializeGame() {
    gameInSession = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      score += 0.05;
      height = -4.9 * score * score + 2.8 * score;
      setState(() {
        yAxis = inHeight - height;
      });
      if (yAxis > 1) {
        timer.cancel();
        setState(() {
          gameInSession = false;
          yAxis = 0;
          inHeight = yAxis;
          score = 0;
          height = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //print("i AM Here");
        if (gameInSession) {
          //print("i AM tap");
          tap();
        } else {
          //print("i AM in");
          initializeGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(children: [
                AnimatedContainer(
                  alignment: Alignment(0, yAxis),
                  duration: Duration(milliseconds: 0),
                  color: Colors.black,
                  child: Mouni(),
                ),
                Container(
                  alignment: Alignment(0, -0.3),
                  child: gameInSession
                      ? Container()
                      : Text(
                          "Tap To Make Mouni jump",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
                AnimatedContainer(
                  alignment: Alignment(x1, -1),
                  duration: Duration(milliseconds: 0),
                  child: Barrier(
                    size: 100.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(x2, 1),
                  duration: Duration(milliseconds: 0),
                  child: Barrier(
                    size: 100.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(x3, -1),
                  duration: Duration(milliseconds: 0),
                  child: Barrier(
                    size: 150.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(x4, 1),
                  duration: Duration(milliseconds: 0),
                  child: Barrier(
                    size: 100.0,
                  ),
                ),
                // AnimatedContainer(
                //   alignment: Alignment(-0.7, -1),
                //   duration: Duration(milliseconds: 0),
                //   child: Barrier(
                //     size: 200.0,
                //   ),
                // ),
              ]),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Score",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Best",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Barrier extends StatelessWidget {
  final size;
  const Barrier({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
      ),
    );
  }
}
