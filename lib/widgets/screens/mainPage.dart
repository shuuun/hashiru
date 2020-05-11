import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:hashiru/blocs/runBloc.dart';

import 'package:hashiru/widgets/components/donutGraph.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _tween;
  final _percentage = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _tween = Tween<double>(begin: 0, end: 100).animate(_controller)
      ..addListener(() { setState(() {}); });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final runBloc = Provider.of<RunBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('HASHIRU'), actions: [IconButton(icon: Icon(Icons.exposure_zero), onPressed: () => _percentage.value = 0,)],),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () async {
          await runBloc.getRunDistance(month: '04');
          _tween = Tween<double>(begin: 0, end: runBloc.runPercentage).animate(_controller)..addListener(() { _percentage.value = _tween.value; });
          _controller.forward(from: 0.0);
        },
      ),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder<double>(
            valueListenable: _percentage,
            builder: (context, percentage, child) {
              return DonutGraph(percentage: percentage, trackColor: Colors.grey[300], completedColor: Colors.redAccent);
            },
          )
        )
      ),
    );
  }
}