import 'package:flutter/services.dart';

import 'package:hashiru/models/workout.dart';

class ApiProvider {

  ApiProvider._();

  static final _channel = MethodChannel('hashiru/workout');

  static Future<List<Workout>> featchWorkoutData() async {
    final workouts = await _channel.invokeMethod('getWorkoutData');
    List<Workout> result = [];
    for (var workout in workouts) {
      final distance = double.parse(workout['total_distance']);
      final _workout = Workout(
        month: workout['workout_month'],
        distance: distance,
        duration: workout['duration']
      );
      result.add(_workout);
    }
    return result;
  }
}