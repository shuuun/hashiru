import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:hashiru/blocs/runBloc.dart';

import 'package:hashiru/widgets/components/goalSettingDialog.dart';

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
          _listTile(title: '目標を再設定する', onPressed: () async {
            Navigator.of(context).pop();
            await GoalSettingDialog().showGoalSettingDialog(context);
            refreshValue();
          }),
          _listTile(title: 'ライセンス情報', onPressed: () {
            showLicensePage(
              context: context,
              applicationName: 'HASHIRU',
            );
          })
        ],
      ),
    );
  }

  Widget _listTile({String title, Function onPressed}) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey))
      ),
      child: RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Icon(Icons.arrow_forward_ios, size: 14,)
          ],
        ),
      )
    );
  }
}