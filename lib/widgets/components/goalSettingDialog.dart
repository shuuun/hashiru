import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: 300,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(icon: FaIcon(FontAwesomeIcons.timesCircle), onPressed: () => Navigator.of(context).pop()),
            ),
            Text('1ヶ月で走る距離を決めましょう!'),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    TextField(
                      controller: _controller,
                      autofocus: true,
                      cursorColor: Colors.redAccent,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('km', style: TextStyle(color: Colors.redAccent),),
                    )
                  ],
                ),
              ),
            ),
            RawMaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              fillColor: Colors.redAccent,
              onPressed: () {
                runBloc.saveGoal(_controller.text);
                Navigator.pop(context);
              },
              child: Container(
                width: 200,
                height: 44,
                alignment: Alignment.center,
                child: Text('設定する', style: TextStyle(color: Colors.white, fontSize: 18),),
              )
            ),
            SizedBox(height: 20,)
          ],
        ),
      )
    );
  }
}