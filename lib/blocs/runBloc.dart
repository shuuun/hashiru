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

  Future<void> getRunDistance({String month}) async {
    await _fetchWorkoutData();
    _runPercentage = _calculateRunPercentage(_filterWorkoutList(_workouts, month ?? DateTime.now().month.toString()));

    notifyListeners();
  }

  Future<void> _fetchWorkoutData() async {
    _workouts = await ApiProvider.featchWorkoutData();
  }

  List<Workout> _filterWorkoutList(List<Workout> workouts, String month) {
    final result = workouts.where((workout) => 
      workout.month == month.padLeft(2, '0')
    ).toList();
    return result;
  }

  double _calculateRunPercentage(List<Workout> workouts) {
    double runDistance = 0.0;
    final goal = 50.0;
    for (var workout in workouts) {
      runDistance += workout.distance;
    }
    final result = (runDistance / goal) * 100;
    return result;
  }
}