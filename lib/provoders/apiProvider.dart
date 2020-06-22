import 'package:flutter/services.dart';

import 'package:hashiru/models/workout.dart';

class ApiProvider {

  ApiProvider._();

  static final _channel = MethodChannel('hashiru/workout');

  static Future<bool> isHKAuthorized() async {
    return await _channel.invokeMethod('isHKAuthorized');
  }

  static Future<List<Workout>> featchWorkoutData() async {
    final List<Map<String, String>> workouts = await _channel.invokeMethod('getWorkoutData');
    var result = <Workout>[];
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