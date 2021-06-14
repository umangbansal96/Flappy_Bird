import 'dart:async';

import 'package:flappy_bird/barriers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialheight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXone = 1.5;
  double barrierXtwo = barrierXone + 1.5;
  int score = 0;

  void jump() {
    setState(() {
      time = 0;
      initialheight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.04;

      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialheight - height;
        barrierXone -= 0.04;
        barrierXtwo -= 0.04;
      });

      setState(() {
        if (barrierXone < -1.5) {
          barrierXone += 3;
        } else {
          barrierXone -= 0.04;
        }

        if (barrierXtwo < -1.5) {
          barrierXtwo += 3;
        } else {
          barrierXtwo -= 0.04;
        }
      });

      if (birdYaxis >= 1.2) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
    Timer.periodic(Duration(milliseconds: 1125), (timer) {
      if(birdYaxis<1.2){score +=1;}else{timer.cancel();
      gameHasStarted = false;}
    });


  }

  @override
  Widget build(BuildContext context) {
    return birdYaxis <= 1.2
        ? GestureDetector(
            onTap: () {
              if (gameHasStarted) {
                jump();
              } else {
                startGame();
              }
            },
            child: Scaffold(
              body: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          alignment: Alignment(0, birdYaxis),
                          duration: Duration(milliseconds: 0),
                          color: Colors.blue,
                          child: MyBird(),
                        ),
                        Container(
                          alignment: Alignment(0, -0.25),
                          child: gameHasStarted
                              ? Text("")
                              : Text(
                                  "T A P  T O  P L A Y",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                        ),

                        AnimatedContainer(
                          duration: Duration(milliseconds: 0),
                          alignment: Alignment(barrierXone, 1),
                          child: MyBarrier(size: 150.0),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 0),
                          alignment: Alignment(barrierXone, -1),
                          child: MyBarrier(size: 150.0),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 0),
                          alignment: Alignment(barrierXtwo, 1),
                          child: MyBarrier(size: 50.0),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 0),
                          alignment: Alignment(barrierXtwo, -1),
                          child: MyBarrier(
                            size: 250.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.green,
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('SCORE',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              score.toString(),
                              style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        color: Colors.brown[600]),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.blue,
            body: Container(
              width: double.infinity,
              child: Center(
                child: Column(

                  children: [
                    SizedBox(height: 80,),
                    Text(
                      "Your Score was",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 30,),
                    Text(
                      score.toString(),
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 120,),
                    RaisedButton(
                      padding: EdgeInsets.all(15),
                      color: Colors.green,
                      child: Text('RESET',style: TextStyle(fontSize: 20,color: Colors.white),),
                      onPressed: () {
                        setState(() {
                          birdYaxis = 0;
                          time = 0;
                          height = 0;
                          initialheight = 0;
                          gameHasStarted = false;
                          barrierXone = 1.5;
                          barrierXtwo = 3;
                          score = 0;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
