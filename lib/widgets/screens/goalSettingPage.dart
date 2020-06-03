import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:hashiru/blocs/runBloc.dart';

import 'package:hashiru/widgets/screens/mainPage.dart';

import 'package:hashiru/widgets/components/roundedButtom.dart';

class GoalSettingPage extends StatefulWidget {
  @override
  _GoalSettingPageState createState() => _GoalSettingPageState();
}

class _GoalSettingPageState extends State<GoalSettingPage> {
  
  final _controller = TextEditingController(text: '');
  final saveButtonEnable = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() { checkTextField(); });
  }

  @override
  void dispose() {
    _controller.dispose();
    saveButtonEnable.dispose();
    super.dispose();
  }

  void checkTextField() {
    final _text = num.tryParse(_controller.text);
    saveButtonEnable.value = _text != 0 && _text != null;
  }
  
  @override
  Widget build(BuildContext context) {
    final runBloc = Provider.of<RunBloc>(context, listen: false);
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
                  TextFormField(
                    controller: _controller,
                    cursorColor: Colors.redAccent,
                    textAlign: TextAlign.center,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 24),
                    toolbarOptions: ToolbarOptions(),
                    autovalidate: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('km', style: TextStyle(color: Colors.redAccent),),
                  )
                ],
              ),
            ),
            SizedBox(height: 40,),
            ValueListenableBuilder<bool>(
              valueListenable: saveButtonEnable,
              builder: (context, enable, child) {
                return RoundedButton(
                  text: '設定する',
                  enabled: enable,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    await runBloc.saveGoal(_controller.text);
                    await runBloc.refreshRunInfo();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MainPage()),
                      (r) => false
                    );
                  },
                );
              },
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: () async {
                FocusScope.of(context).unfocus();
                await runBloc.saveGoal('50');
                await runBloc.refreshRunInfo();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MainPage()),
                  (r) => false
                );
              },
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide())
                ),
                child: Text('スキップする'),
              ),
            )
          ],
        ),
      ),
    );
  }
}