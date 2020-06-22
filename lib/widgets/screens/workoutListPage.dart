import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hashiru/blocs/runBloc.dart';

import 'package:hashiru/models/workout.dart';

import 'package:hashiru/widgets/components/notExistsWorkoutView.dart';
import 'package:hashiru/widgets/components/notAuthorizedView.dart';

class WorkoutListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final runBloc = Provider.of<RunBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('ランニングの履歴'),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.filter),
            onPressed: () {

            },
          )
        ],
      ),
      body: SafeArea(
        child: Consumer<RunBloc>(
          builder: (context, bloc, child) {
            if (bloc.isHKAuthorized == null) return Center(child: CircularProgressIndicator(),);
            if (bloc.isHKAuthorized == false) return NotAuthorizedPage(onRefresh: bloc.refreshRunInfo);
            if (bloc.isHKAuthorized == true && runBloc.existsWorkout == false) return NotExistsWorkoutView(onRefresh: bloc.refreshRunInfo,);
            return ListView.builder(
              itemCount: runBloc.workouts.length,
              itemBuilder: (context, index) {
                return WorkoutListTile(workout: bloc.workouts[index],);
              },
            );
          },
        )
      ),
    );
  }
}

class WorkoutListTile extends StatelessWidget {

  final Workout workout;

  WorkoutListTile({this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey[400],
        //     offset: Offset(0.0, 3.0),
        //     blurRadius: 5.0
        //   )
        // ]
      ),
      child: Row(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(workout.workoutDay, style: TextStyle(fontSize: 16, color: Colors.black),),
                Text('合計時間 : ' + workout.duration, style: TextStyle(fontSize: 16, color: Colors.black))
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 38,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(workout.distance.toStringAsFixed(2), textAlign: TextAlign.end, style: TextStyle(color: Colors.redAccent, fontSize: 35, fontWeight: FontWeight.bold),),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text('km', style: TextStyle(fontSize: 20, color: Colors.black),),
                )
              ],
            ),
            )
          )
        ],
      )
    );
  }
}