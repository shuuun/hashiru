import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hashiru/models/workout.dart';

import 'package:hashiru/provoders/apiProvider.dart';

class RunBloc with ChangeNotifier {

  RunBloc() {
    refreshRunInfo();
  }

  double _runDistance;
  double get runDistance => _runDistance;

  double _runPercentage;
  double get runPercentage => _runPercentage;

  // default value
  double _goal = 100;
  double get goal => _goal;

  List<Workout> _workouts;

  /// アクセスが許可されたかどうか
  bool isHKAuthorized;

  bool existsWorkout = false;

  List<String> getWorkedoutMonths() {
    // return _workouts.map((w) => w.month).toList();
    return _workouts.map((w) => w.month).toSet().toList();
  }

  Future<void> refreshRunInfo({String workoutMonth}) async {
    final now = DateTime.now();
    await _checkHKAuthoraized();
    if (isHKAuthorized) {
      await _loadWorkoutData();
      if (_workouts.isEmpty) {
        clear();
        return;
      }
      await loadSavedGoal();
      _runPercentage = _calculateRunPercentage(_filterWorkoutList(_workouts, workoutMonth ?? '${now.year}/${now.month.toString().padLeft(2, '0')}'));
    }
    notifyListeners();
  }

  Future<void> _checkHKAuthoraized() async {
    isHKAuthorized = await ApiProvider.isHKAuthorized();
  }

  Future<void> _loadWorkoutData() async {
    _workouts = await ApiProvider.featchWorkoutData();
    existsWorkout = _workouts.isNotEmpty;
    notifyListeners();
  }

  List<Workout> _filterWorkoutList(List<Workout> workouts, String month) {
    final result = workouts.where((workout) => 
      workout.month == month
    ).toList();
    return result;
  }

  double _calculateRunPercentage(List<Workout> workouts) {
    if (workouts.isEmpty) return 0;
    final runDistanceList = workouts.map((w) => w.distance).toList();
    _runDistance = runDistanceList.reduce((current, next) => current + next);
    final result = (runDistance / _goal) * 100;
    return double.parse(result.toStringAsFixed(0));
  }

  Future<void> loadSavedGoal() async {
    final prefs = await SharedPreferences.getInstance();
    _goal = prefs.getDouble('goal') ?? _goal;
  }

  Future<void> saveGoal(String goal) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('goal', double.parse(goal));
  }

  void clear() {
    _runDistance = null;
    _runPercentage = null;
    _workouts = null;
    isHKAuthorized = false;
    notifyListeners();
  }
}