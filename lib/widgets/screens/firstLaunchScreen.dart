import 'package:flutter/material.dart';

import 'package:hashiru/widgets/screens/goalSettingPage.dart';

class FirstLaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width <= 768 ? GoalSettingPage() : Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🙇‍♂️', style: TextStyle(fontSize: 100),),
            SizedBox(height: 20,),
            Text('このアプリはiPadでは使用できません。\n iPhoneでのみ利用可能です。\n インストールして頂きありがとうございました。', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),
          ],
        ),
      ),
    );
  }
}