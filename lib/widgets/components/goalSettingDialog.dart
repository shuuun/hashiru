import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hashiru/blocs/runBloc.dart';

import 'package:hashiru/widgets/components/roundedButtom.dart';

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

  @override
  Widget build(BuildContext context) {
    final runBloc = Provider.of<RunBloc>(context, listen: false);
    final _controller = TextEditingController(text: runBloc.goal.toStringAsFixed(0));
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
            RoundedButton(
              text: '設定する',
              onPressed: () async {
                await runBloc.saveGoal(_controller.text);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20,)
          ],
        ),
      )
    );
  }
}