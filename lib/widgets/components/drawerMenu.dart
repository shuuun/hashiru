import 'package:flutter/material.dart';

import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:provider/provider.dart';

import 'package:hashiru/blocs/runBloc.dart';

import 'package:hashiru/widgets/components/goalSettingDialog.dart';
import 'package:hashiru/widgets/components/customListTile.dart';

import 'package:hashiru/widgets/screens/workoutListPage.dart';
import 'package:hashiru/widgets/screens/markdownRenderPage.dart';

class DrawerMenu extends StatelessWidget {
  final Future<void> Function() refreshValue;
  final browser = ChromeSafariBrowser(bFallback: InAppBrowser());

  DrawerMenu(this.refreshValue);

  @override
  Widget build(BuildContext context) {
    final runBloc = Provider.of<RunBloc>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.redAccent),
            margin: EdgeInsets.all(0),
            child: Text('HASHIRU', style: TextStyle(fontSize: 24, color: Colors.white),),
          ),
          runBloc.isHKAuthorized == false ? Container() : 
            CustomListTile(title: 'ランニングの履歴', onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => WorkoutListPage())
              );
            }),
          runBloc.isHKAuthorized == false ? Container() : 
            CustomListTile(title: '目標を再設定する', onPressed: () async {
              Navigator.of(context).pop();
              await GoalSettingDialog().showGoalSettingDialog(context);
              refreshValue();
            }),
          CustomListTile(title: 'お問い合わせ', onPressed: () async {
            Navigator.of(context).pop();
            await browser.open(
              url: 'https://docs.google.com/forms/d/e/1FAIpQLSe4vGEiu9Y8V5QXzgEw8UUMQ9e25rz9m5VisdC1jRe9qjwyig/viewform?usp=sf_link',
              options: ChromeSafariBrowserClassOptions(
                iosSafariOptions: IosSafariOptions()
              )
            );
          }),
          CustomListTile(title: 'ライセンス', onPressed: () => showLicensePage(context: context,applicationName: 'HASHIRU',),),
          CustomListTile(title: '利用規約', onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MarkdownRenderPage(title: '利用規約', filePath: 'docs/eula.md',))
            );
          }),
          CustomListTile(title: 'プライバシーポリシー', onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MarkdownRenderPage(title: 'プライバシーポリシー', filePath: 'docs/policy.md',))
            );
          },)
        ],
      ),
    );
  }
}