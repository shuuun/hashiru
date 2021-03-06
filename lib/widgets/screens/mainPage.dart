import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hashiru/blocs/runBloc.dart';

import 'package:hashiru/widgets/components/dropDownButton.dart';
import 'package:hashiru/widgets/components/workoutMonthPicker.dart';
import 'package:hashiru/widgets/components/notAuthorizedView.dart';
import 'package:hashiru/widgets/components/notExistsWorkoutView.dart';
import 'package:hashiru/widgets/components/customCard.dart';
import 'package:hashiru/widgets/components/goalSettingDialog.dart';

class MainPage extends StatelessWidget {
  
  final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey<AnimatedCircularChartState>();
  final workedoutMonth = ValueNotifier<String>('${DateTime.now().year.toString()}/${DateTime.now().month.toString().padLeft(2, '0')}');
  
  @override
  Widget build(BuildContext context) {
    final runBloc = Provider.of<RunBloc>(context, listen: false);

    Future<void> refreshValue() async {
      await runBloc.refreshRunInfo(workoutMonth: workedoutMonth.value);
      if (runBloc.isHKAuthorized == true) {
        if (_chartKey.currentState != null) {
          _chartKey.currentState.updateData(generateChartData(runBloc.runPercentage));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        // デバッグする用
        title: InkWell(
          onTap: () => runBloc.insertDummyData(),
          child: Text('HASHIRU'),
        ),
        // title: Text('HASHIRU'),
        actions: [
          Consumer<RunBloc>(
            builder: (context, bloc, child) {
              if (bloc.isHKAuthorized == null) return Container();
              return bloc.isHKAuthorized ? 
                IconButton(
                  icon: Icon(FontAwesomeIcons.flag),
                  onPressed: () async {
                    await GoalSettingDialog().showGoalSettingDialog(context);
                    await refreshValue();
                  },
                ) : Container();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Selector<RunBloc, bool>(
          selector: (context, state) => state.isHKAuthorized,
          builder: (context, isHKAuthorized, child) {
            if (isHKAuthorized == null) return Center(child: CircularProgressIndicator(),);
            if (isHKAuthorized == true && runBloc.existsWorkout == false) return NotExistsWorkoutView(onRefresh: refreshValue,);
            return isHKAuthorized ? 
              RefreshIndicator(
                onRefresh: () async => await refreshValue(),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20,),
                        DropDownButton(
                          content: workedoutMonth,
                          onPressed: () async {
                            workedoutMonth.value = await WorkoutMonthPicker().showPicker(context, contents: runBloc.getWorkedoutMonths(), defaultValue: workedoutMonth.value);
                            await refreshValue();
                          },
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomCard(
                            child: Consumer<RunBloc>(
                              builder: (context, bloc, child) {
                                return Column(
                                  children: [
                                    Text('目標', style: TextStyle(fontSize: 15), textAlign: TextAlign.start,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(bloc.runDistance != null ? bloc.goal.toStringAsFixed(1) : '--', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 27),),
                                        Text('km', textAlign: TextAlign.center, style: TextStyle(fontSize: 14),)
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: CustomCard(
                            child: Consumer<RunBloc>(
                              builder: (context, bloc, child) {
                                return Column(
                                  children: [
                                    Text('現在', style: TextStyle(fontSize: 15), textAlign: TextAlign.start,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(bloc.runDistance != null ? bloc.runDistance.toStringAsFixed(1) : '--', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 27),),
                                        Text('km', textAlign: TextAlign.center, style: TextStyle(fontSize: 14),)
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: CustomCard(
                            child: Consumer<RunBloc>(
                              builder: (context, bloc, child) {
                                return Column(
                                  children: [
                                    Text('達成率', style: TextStyle(fontSize: 15)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(bloc.runPercentage != null ? bloc.runPercentage.toStringAsFixed(0) : '--', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 27),),
                                        Text('%')
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          )
                        )
                      ],
                    ),
                    Consumer<RunBloc>(
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
                              holeLabel: 'HASHITTA',
                              labelStyle: TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          );
                      },
                    ),
                  ],
                ),
              ) : NotAuthorizedPage(onRefresh: refreshValue,);
          },
        )
      )
    );
  }

  List<CircularStackEntry> generateChartData(double value) {
    if (value == null) return [];

    var data = <CircularStackEntry>[];

    var counter = value;

    while(counter > 100) {
      data.add(
        CircularStackEntry(
          [
            CircularSegmentEntry(counter, Colors.green[300], rankKey: 'completed line')
          ]
        )
      );
      counter -= 100;
    }

    data.add(
      CircularStackEntry(
        [
          CircularSegmentEntry(counter, Colors.green[300], rankKey: 'completed line')
        ]
      )
    );

    return data;
  }
}