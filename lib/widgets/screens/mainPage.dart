import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hashiru/blocs/runBloc.dart';

import 'package:hashiru/widgets/components/goalSettingDialog.dart';
import 'package:hashiru/widgets/components/likeDropDownButton.dart';
import 'package:hashiru/widgets/components/selectWorkoutMonthPicker.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey<AnimatedCircularChartState>();
  final workedoutMonth = ValueNotifier<String>('${DateTime.now().year.toString()}/${DateTime.now().month.toString().padLeft(2, '0')}');

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
          IconButton(icon: FaIcon(FontAwesomeIcons.running), onPressed: () async { 
            await GoalSettingDialog().showGoalSettingDialog(context);
            await runBloc.getRunDistance(workoutMonth: workedoutMonth.value);
            setState(() {
              _chartKey.currentState.updateData(generateChartData(runBloc.runPercentage));
            });
          },)
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            LikeDropDownButton(
              content: workedoutMonth,
              onPressed: () async {
                workedoutMonth.value = await SelectWorkoutMonthPicker().showPicker(context, runBloc.getWorkedoutMonths(), workedoutMonth.value);
                await runBloc.getRunDistance(workoutMonth: workedoutMonth.value);
                setState(() {
                  _chartKey.currentState.updateData(generateChartData(runBloc.runPercentage));
                });
              },
            ),
            SizedBox(height: 20,),
            Consumer<RunBloc>(
              builder: (context, bloc, child) {
                return Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '走った距離 : ',
                        style: DefaultTextStyle.of(context).style.copyWith(fontSize: 20),
                        children: [
                          TextSpan(
                            text: bloc.runDistance.toStringAsFixed(2),
                            style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 33)
                          ),
                          TextSpan(
                            text: ' km'
                          )
                        ]
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('目標達成まであと${(bloc.goal - bloc.runDistance).toStringAsFixed(2)}km')
                  ],
                );
              },
            ),
            Expanded(
              child: Consumer<RunBloc>(
                builder: (context, bloc, child) {
                  return bloc.runPercentage == null ?
                    Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),),) : 
                    Container(
                      alignment: Alignment.center,
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
            ),
          ],
        ),
      )
    );
  }
}