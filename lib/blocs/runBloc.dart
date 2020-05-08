import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:hashiru/models/run.dart';

class RunBloc with ChangeNotifier {

  RunBloc(){
    fetchRunDistance();
  }

  Run _run;

  double _runDistance;
  double get runDistance => _runDistance;

  double _runPercentage;
  double get runPercentage => _runPercentage;

  void initRunModel() {

  }

  Future<void> fetchRunDistance() async {
    _runPercentage = Random().nextInt(100).toDouble();
    notifyListeners();
  }

  void calculatRunPercentage() {

  }
}