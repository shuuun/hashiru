import 'package:flutter/material.dart';

import 'package:hashiru/widgets/components/donutGraph.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
      ..addListener(() { 
        // percentage.value = lerpDouble(percentage.value, randomPercentage.value, _controller.value);
      });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HASHIRU'),),
      body: SafeArea(
        child: Center(child: DonutGraph(percentage: 60, trackColor: Colors.grey[300], completedColor: Colors.redAccent),)
      ),
    );
  }
}