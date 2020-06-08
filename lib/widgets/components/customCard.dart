import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {

  final Widget child;
  CustomCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        height: 85,
        padding: EdgeInsets.all(10),
        child: child,
      )
    );
  }
}