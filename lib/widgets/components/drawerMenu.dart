import 'package:flutter/material.dart';

import 'package:hashiru/widgets/components/goalSettingDialog.dart';
import 'package:hashiru/widgets/components/customListTile.dart';

import 'package:hashiru/widgets/screens/workoutListPage.dart';

class DrawerMenu extends StatelessWidget {
  final Future<void> Function() refreshValue;

  DrawerMenu(this.refreshValue);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.redAccent),
            margin: EdgeInsets.all(0),
            child: Text('HASHIRU', style: TextStyle(fontSize: 24, color: Colors.white),),
          ),
          CustomListTile(title: '走った履歴', onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WorkoutListPage())
            );
          }),
          CustomListTile(title: '目標を再設定する', onPressed: () async {
            Navigator.of(context).pop();
            await GoalSettingDialog().showGoalSettingDialog(context);
            refreshValue();
          }),
          CustomListTile(title: 'ライセンス', onPressed: () => showLicensePage(context: context,applicationName: 'HASHIRU',),)
        ],
      ),
    );
  }
}