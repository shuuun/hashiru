import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:pedantic/pedantic.dart';

import 'package:hashiru/widgets/screens/firstLaunchScreen.dart';

import 'package:hashiru/widgets/screens/pageSwitcher.dart';


class AppLoadingPage extends StatefulWidget {
  @override
  _AppLoadingPageState createState() => _AppLoadingPageState();
}

class _AppLoadingPageState extends State<AppLoadingPage> {

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final goal = prefs.getDouble('goal');
    if (goal == null) {
      if (mounted) {
        unawaited(Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => FirstLaunchScreen()),
          (r) => false
        ));
      }
      return;
    }
    unawaited(Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => PageSwitcher()),
      (r) => false
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: Center(
          child: Image.asset('assets/images/Icon.jpg'),
        )
      ),
    );
  }
}