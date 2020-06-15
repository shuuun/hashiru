import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {

  final Widget child;
  final double height;
  final double width;
  CustomCard({@required this.child, this.height = 75, this.width});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 2,
      child: Container(
        height: height,
        padding: EdgeInsets.all(10),
        child: child,
      )
    );
  }
}