import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:hashiru/models/workout.dart';

class ApiProvider {

  ApiProvider._();

  static final _channel = MethodChannel('hashiru/workout');

  static Future<bool> isHKAuthorized() async {
    return await _channel.invokeMethod('isHKAuthorized');
  }

  static Future<List<Workout>> featchWorkoutData() async {
    final workouts = await _channel.invokeMethod('getWorkoutData');
    List<Workout> result = [];
    for (var workout in workouts) {
      final distance = double.parse(workout['total_distance']);
      final _workout = Workout(
        workoutDay: workout['workout_day'],
        workoutYYYYMM: workout['workout_yyyymm'],
        distance: distance,
        duration: workout['duration']
      );
      result.add(_workout);
    }
    return result;
  }
}