import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:hashiru/models/workout.dart';

import 'package:hashiru/provoders/apiProvider.dart';

class RunBloc with ChangeNotifier {

  RunBloc(){
    getRunDistance();
  }

  double _runDistance;
  double get runDistance => _runDistance;

  double _runPercentage;
  double get runPercentage => _runPercentage;

  List<Workout> _workouts;

  final storage = FlutterSecureStorage();

  void initRunModel() {

  }

  Future<void> _fetchWorkoutData() async {
    _workouts = await ApiProvider.featchWorkoutData();
  }

  Future<void> getRunDistance({String month}) async {
    _runPercentage = Random().nextInt(100).toDouble();
    await _fetchWorkoutData();
    _runPercentage = _calculatRunPercentage(_filterWorkoutList(_workouts, month ?? DateTime.now().month.toString()));
    // _filterWorkoutList(_workouts, month ?? DateTime.now().month.toString());
    notifyListeners();
  }

  List<Workout> _filterWorkoutList(List<Workout> workouts, String month) {
    final result = workouts.where((workout) => 
      workout.month == month.padLeft(2, '0')
    ).toList();
    return result;
  }

  double _calculatRunPercentage(List<Workout> workouts) {
    double runDistance = 0.0;
    final goal = 50.0;
    for (var workout in workouts) {
      runDistance += workout.distance;
    }
    final result = (runDistance / goal) * 100;
    return result;
  }
}