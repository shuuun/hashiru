import 'package:fit_kit/fit_kit.dart';

import 'package:hashiru/models/run.dart';

class ApiProvider {

  ApiProvider._();

  static Future<void> readRunData() async {
    try {
      final permission = await FitKit.requestPermissions(DataType.values);
      if (!permission) {
        // TODO: 考える
        print('権限がないらしい');
      }
      final result = await FitKit.readLast(
        DataType.DISTANCE,
      );
      print(result);
    } catch(e) {
      print(e);
    }
  }
}