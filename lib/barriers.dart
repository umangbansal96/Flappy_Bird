import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;
  MyBarrier({this.size});



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: size,
      color: Colors.green,
    );
  }
}
