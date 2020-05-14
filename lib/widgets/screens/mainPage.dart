import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import 'package:hashiru/blocs/runBloc.dart';

import 'package:hashiru/widgets/components/goalSettingDialog.dart';
import 'package:hashiru/widgets/components/likeDropDownButton.dart';
import 'package:hashiru/widgets/components/selectWorkoutMonthPicker.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {

  final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey<AnimatedCircularChartState>();
  final workedoutMonth = ValueNotifier<String>('2020/05');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
      appBar: AppBar(
        title: Text('HASHIRU'),
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: () { GoalSettingDialog().showGoalSettingDialog(context); },)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () async {
          await runBloc.getRunDistance(workoutMonth: '2020/04');
          setState(() {
            _chartKey.currentState.updateData(generateChartData(runBloc.runPercentage));
          });
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            LikeDropDownButton(
              content: workedoutMonth,
              onPressed: () async {
                print(runBloc.getWorkedoutMonths());
                workedoutMonth.value = await SelectWorkoutMonthPicker().showPicker(context, runBloc.getWorkedoutMonths(), workedoutMonth.value);
                await runBloc.getRunDistance(workoutMonth: workedoutMonth.value);
                setState(() {
                  _chartKey.currentState.updateData(generateChartData(runBloc.runPercentage));
                });
              },
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Consumer<RunBloc>(
                builder: (context, bloc, child) {
                  return bloc.runPercentage == null ?
                    CircularProgressIndicator() : 
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(border: Border.all()),
                      child: AnimatedCircularChart(
                        key: _chartKey,
                        percentageValues: true,
                        size: Size(350, 350),
                        chartType: CircularChartType.Radial,
                        initialChartData: generateChartData(bloc.runPercentage),
                        holeLabel: '${bloc.runPercentage.toStringAsFixed(0)}%',
                      ),
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}