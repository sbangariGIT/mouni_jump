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
      height = (-4.9 * score * score) + (2.8 * score);
      setState(() {
        yAxis = inHeight - height;
      });
      if (yAxis > 1) {
        timer.cancel();
        gameInSession = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                if (gameInSession) {
                  tap();
                } else {
                  initializeGame();
                }
              },
              child: AnimatedContainer(
                alignment: Alignment(0, 0),
                duration: Duration(milliseconds: 0),
                color: Colors.black,
                child: Center(child: Mouni()),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Column(
                    children: [Text("Score"), Text("0")],
                  ),
                  Column(
                    children: [Text("Best"), Text("0")],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
