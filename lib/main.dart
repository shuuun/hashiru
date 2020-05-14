import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:hashiru/widgets/screens/mainPage.dart';

import 'package:hashiru/blocs/runBloc.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RunBloc(),
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hashiru',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none
        )
      ),
      // TextFieldコピペ時の問題やポップアップメニューの正しいローカライズのために
      // localizationsDelegates を指定することが必須。
      // https://github.com/flutter/flutter/issues/19120
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // 文字化けなどの問題に対策するためには対応しているロケールのリストを列挙する
      // 必要がある。また、 Info.plist の CFBundleLocalizations には、対応する
      // ロケールの列記が必要。
      supportedLocales: const [
        Locale('ja')
      ],
      home: MainPage(),
    );
  }
}