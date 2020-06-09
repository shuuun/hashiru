import 'package:flutter/material.dart';

import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

import 'package:hashiru/widgets/screens/markdownRenderPage.dart';

import 'package:hashiru/widgets/components/customListTile.dart';

class SettingPage extends StatelessWidget {

  final browser = ChromeSafariBrowser(bFallback: InAppBrowser());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('設定')),
      body: ListView(
        children: [
          CustomListTile(title: 'お問い合わせ', onPressed: () async {
            await browser.open(
              url: 'https://docs.google.com/forms/d/e/1FAIpQLSe4vGEiu9Y8V5QXzgEw8UUMQ9e25rz9m5VisdC1jRe9qjwyig/viewform?usp=sf_link',
              options: ChromeSafariBrowserClassOptions(
                iosSafariOptions: IosSafariOptions()
              )
            );
          }),
          CustomListTile(title: 'ライセンス', onPressed: () => showLicensePage(context: context,applicationName: 'HASHIRU',),),
          CustomListTile(title: '利用規約', onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MarkdownRenderPage(title: '利用規約', filePath: 'docs/eula.md',))
            );
          }),
          CustomListTile(title: 'プライバシーポリシー', onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MarkdownRenderPage(title: 'プライバシーポリシー', filePath: 'docs/policy.md',))
            );
          },)
        ],
      ),
    );
  }
}