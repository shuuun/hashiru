import 'package:flutter/services.dart';

import 'package:fit_kit/fit_kit.dart';

import 'package:hashiru/models/run.dart';

class ApiProvider {

  ApiProvider._();

  static final _channel = MethodChannel('hashiru');

  static Future<void> readRunData() async {
    await _channel.invokeMethod('getWorkoutData');
  }
}