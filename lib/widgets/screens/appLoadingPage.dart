import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:hashiru/widgets/screens/mainPage.dart';
import 'package:hashiru/widgets/screens/firstLaunchScreen.dart';


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
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => FirstLaunchScreen()),
          (r) => false
        );
      }
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => MainPage()),
      (r) => false
    );
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