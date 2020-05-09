import 'package:flutter/services.dart';

import 'package:fit_kit/fit_kit.dart';

import 'package:hashiru/models/run.dart';

class ApiProvider {

  ApiProvider._();

  static final _channel = MethodChannel('hashiru/workout');

  static Future<void> readRunData() async {
    final result = await _channel.invokeMethod('getWorkoutData');
    print(result);
  }
}