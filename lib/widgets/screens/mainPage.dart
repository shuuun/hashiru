import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hashiru/blocs/runBloc.dart';

import 'package:hashiru/widgets/components/goalSettingDialog.dart';
import 'package:hashiru/widgets/components/likeDropDownButton.dart';
import 'package:hashiru/widgets/components/selectWorkoutMonthPicker.dart';
import 'package:hashiru/widgets/components/notAuthorizedView.dart';
import 'package:hashiru/widgets/components/notExistsWorkoutView.dart';
import 'package:hashiru/widgets/components/drawerMenu.dart';

class MainPage extends StatelessWidget {
  
  final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey<AnimatedCircularChartState>();
  final workedoutMonth = ValueNotifier<String>('${DateTime.now().year.toString()}/${DateTime.now().month.toString().padLeft(2, '0')}');

  List<CircularStackEntry> generateChartData(double value) {
    if (value == null) return [];

    List<CircularStackEntry> data = [];

    double counter = value;

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
        title: Text('HASHIRU'),
      ),
      drawer: Consumer<RunBloc>(
        builder: (context, bloc, child) {
          if (bloc.isHKAuthorized == null || bloc.isHKAuthorized == true && runBloc.existsWorkout == false) return Container();
          return bloc.isHKAuthorized ? DrawerMenu(refreshValue) : Container();
        },
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
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        LikeDropDownButton(
                          content: workedoutMonth,
                          onPressed: () async {
                            workedoutMonth.value = await SelectWorkoutMonthPicker().showPicker(context, runBloc.getWorkedoutMonths(), workedoutMonth.value);
                            await refreshValue();
                          },
                        ),
                        SizedBox(height: 20,),
                        Consumer<RunBloc>(
                          builder: (context, bloc, child) {
                            return Column(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: '1ヶ月の目標 : ',
                                    style: DefaultTextStyle.of(context).style.copyWith(fontSize: 20),
                                    children: [
                                      TextSpan(
                                        text: bloc.runDistance != null ? bloc.goal.toStringAsFixed(1) : '--',
                                        style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 33)
                                      ),
                                      TextSpan(
                                        text: ' km'
                                      )
                                    ]
                                  ),
                                ),
                                SizedBox(height: 10,),
                              ],
                            );
                          },
                        ),
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
                                        text: bloc.runDistance != null ? bloc.runDistance.toStringAsFixed(1) : '--',
                                        style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 33)
                                      ),
                                      TextSpan(
                                        text: ' km'
                                      )
                                    ]
                                  ),
                                ),
                                SizedBox(height: 10,),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 30,),
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
                        Selector<RunBloc, double>(
                          selector: (context, per) => per.runPercentage,
                          builder: (context, per, child) {
                            return RichText(
                              text: TextSpan(
                                text: '達成率 : ',
                                style: DefaultTextStyle.of(context).style.copyWith(fontSize: 20),
                                children: [
                                  TextSpan(
                                    text: per != null ? per.toStringAsFixed(0) : '--',
                                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 33)
                                  ),
                                  TextSpan(text: ' %')
                                ]
                              ),
                            );
                          },
                        ),
                        Expanded(child: Container(),)
                      ],
                  ),
                )
              )
            ) : NotAuthorizedPage(onRefresh: refreshValue,);
          },
        )
      )
    );
  }
}