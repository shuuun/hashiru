import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import 'package:hashiru/blocs/runBloc.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _percentageAnimation;
  final _percentage = ValueNotifier<double>(160);
  final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey<AnimatedCircularChartState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    // _percentageAnimation = Tween<double>(begin: 0, end: 100).animate(_controller)
    //   ..addListener(() { setState(() {}); });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<CircularStackEntry> generateChartData(double value) {
    List<CircularStackEntry> data = [
      CircularStackEntry(
        [
          CircularSegmentEntry(value, Colors.green[300], rankKey: 'completed line')
        ]
      )
    ];
    
    if (value > 100) {
      data.add(
        CircularStackEntry(
          [
            CircularSegmentEntry(value - 100, Colors.green[300], rankKey: 'completed line')
          ]
        )
      );
    }
    return data;
  }
  
  @override
  Widget build(BuildContext context) {
    final runBloc = Provider.of<RunBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('HASHIRU'), actions: [IconButton(icon: Icon(Icons.exposure_zero), onPressed: () => _percentage.value = 0,)],),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () async {
          await runBloc.getRunDistance('2020/04');
          // _percentage.value = runBloc.runPercentage;
          _percentage.value = Random().nextInt(200).toDouble();
          setState(() {
            _chartKey.currentState.updateData(generateChartData(_percentage.value));
          });
          // _percentageAnimation = Tween<double>(begin: 0, end: runBloc.runPercentage).animate(_controller)..addListener(() { _percentage.value = _percentageAnimation.value; });
          // _controller.forward(from: 0.0);
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            // DropdownButton(
            //   items: runBloc.getWorkoutDays(),
            //   onChanged: (day) async {
            //     await runBloc.getRunDistance(month: day);
            //     _percentageAnimation = Tween<double>(begin: 0, end: runBloc.runPercentage).animate(_controller)..addListener(() { _percentage.value = _percentageAnimation.value; });
            //     _controller.forward(from: 0.0);
            //   }
            // ),
            ValueListenableBuilder<double>(
              valueListenable: _percentage,
              builder: (context, percentage, child) {
                return AnimatedCircularChart(
                  key: _chartKey,
                  percentageValues: true,
                  size: Size(350, 350),
                  chartType: CircularChartType.Radial,
                  initialChartData: generateChartData(percentage),
                  holeLabel: '$percentage%',
                );
              },
            )
          ],
        ),
      )
    );
  }
}