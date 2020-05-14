import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hashiru/models/workout.dart';

import 'package:hashiru/provoders/apiProvider.dart';

class RunBloc with ChangeNotifier {

  RunBloc() {
    getRunDistance();
  }

  double _runDistance;
  double get runDistance => _runDistance;

  double _runPercentage;
  double get runPercentage => _runPercentage;

  // default value
  double _goal = 100;
  double get goal => _goal;

  List<Workout> _workouts;

  List<String> getWorkedoutMonths() {
    // return _workouts.map((w) => w.month).toList();
    return _workouts.map((w) => w.month).toSet().toList();
  }

  Future<void> getRunDistance({String workoutMonth}) async {
    await _loadWorkoutData();
    await loadSavedGoal();
    // _runPercentage = _calculateRunPercentage(_filterWorkoutList(_workouts, workoutMonth));
    _runPercentage = (Random().nextInt(200).toDouble() / _goal) * 100;
    notifyListeners();
  }

  Future<void> _loadWorkoutData() async {
    _workouts = await ApiProvider.featchWorkoutData();
  }

  List<Workout> _filterWorkoutList(List<Workout> workouts, String month) {
    final result = workouts.where((workout) => 
      workout.month == month
    ).toList();
    return result;
  }

  double _calculateRunPercentage(List<Workout> workouts) {
    double runDistance = 0.0;
    workouts.map((w) => runDistance += w.distance);
    final result = (runDistance / _goal) * 100;
    return double.parse(result.toStringAsFixed(0));
  }

  Future<void> loadSavedGoal() async {
    final prefs = await SharedPreferences.getInstance();
    _goal = prefs.getDouble('goal') ?? _goal;
  }

  Future<void> saveGoal(double goal) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('goal', goal);
  }
}