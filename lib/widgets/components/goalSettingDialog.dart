import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:hashiru/blocs/runBloc.dart';

class GoalSettingDialog {
  Future<void> showGoalSettingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return _GoalSettingDialog();
      },
    );
  }
}

class _GoalSettingDialog extends StatelessWidget {

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final runBloc = Provider.of<RunBloc>(context, listen: false);
    return Dialog(
      child: Container(
        height: 300,
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            Text('1ヶ月であなたがHASHIRU距離を設定しましょう！'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TextField(
                    controller: _controller,
                    autofocus: true,
                    cursorColor: Colors.redAccent,
                    keyboardType: TextInputType.number,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('km', style: TextStyle(color: Colors.redAccent),),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}