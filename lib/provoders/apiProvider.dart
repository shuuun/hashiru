import 'package:flutter/services.dart';

import 'package:hashiru/models/workout.dart';

class ApiProvider {

  ApiProvider._();

  static final _channel = MethodChannel('hashiru/workout');

  static Future<bool> isHKAuthorized() async {
    return await _channel.invokeMethod('isHKAuthorized');
  }

  static Future<List<Workout>> featchWorkoutData() async {
    //FIXME: ここでList<Map<String, String>>みたいな感じでキャストしたい
    final workouts = await _channel.invokeMethod('getWorkoutData');
    var result = <Workout>[];
    for (var workout in workouts) {
      final distance = double.parse(workout['total_distance'] as String);
      final _workout = Workout(
        workoutDay: workout['workout_day'] as String,
        workoutYYYYMM: workout['workout_yyyymm'] as String,
        distance: distance,
        duration: workout['duration'] as String
      );
      result.add(_workout);
    }
    return result;
  }
}