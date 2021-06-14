import 'package:flappy_bird/homepage.dart';
import 'package:flutter/material.dart';

class ResetGame extends StatefulWidget {
  final int finalscore;


  ResetGame({this.finalscore});


  @override
  _ResetGameState createState() => _ResetGameState();
}


class _ResetGameState extends State<ResetGame> {
  @override
  bool reset = false;
  Widget build(BuildContext context) {
    return reset == false ? Scaffold(backgroundColor: Colors.green,
        body: Container(width: double.infinity,
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text("Your Score was",style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),),
                Text(widget.finalscore.toString(),style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),),
                RaisedButton(child: Text('RESET'),onPressed: () {},),
              ],
            ),
          ),
        ),

    ): HomePage();
  }
}
