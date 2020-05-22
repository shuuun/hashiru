import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:hashiru/blocs/runBloc.dart';

import 'package:hashiru/widgets/screens/mainPage.dart';

import 'package:hashiru/widgets/components/roundedButtom.dart';

class GoalSettingPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final runBloc = Provider.of<RunBloc>(context, listen: false);
    final _controller = TextEditingController(text: runBloc.goal.toStringAsFixed(0));
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Text.rich(
              TextSpan(
                text: '1ヶ月で\n',
                style: DefaultTextStyle.of(context).style.copyWith(fontSize: 24, decoration: TextDecoration.none, color: Colors.black87),
                children: [
                  TextSpan(
                    text: 'HASHIRU\n',
                    style: TextStyle(color: Colors.redAccent, fontSize: 26)
                  ),
                  TextSpan(
                    text: '距離を決めましょう！',
                  ),
                ]
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TextField(
                    controller: _controller,
                    cursorColor: Colors.redAccent,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 24),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('km', style: TextStyle(color: Colors.redAccent),),
                  )
                ],
              ),
            ),
            SizedBox(height: 40,),
            RoundedButton(
              text: '設定する',
              onPressed: () async {
                await runBloc.saveGoal(_controller.text);
                await runBloc.refreshRunInfo();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MainPage()),
                  (r) => false
                );
              },
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}