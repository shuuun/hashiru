import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:hashiru/models/ran.dart';

class RanBloc with ChangeNotifier {

  RanBloc(){
    fetchRanDistance();
  }

  double _ranDistance;
  double get ranDistance => _ranDistance;

  double _ranPercentage;
  double get ranPercentage => _ranPercentage;

  Future<void> fetchRanDistance() async {
    _ranPercentage = Random().nextInt(100).toDouble();
    notifyListeners();
  }
}