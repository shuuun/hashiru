import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hashiru/widgets/screens/workoutListPage.dart';
import 'package:hashiru/widgets/screens/mainPage.dart';
import 'package:hashiru/widgets/screens/settingPage.dart';

class PageSwitcher extends StatelessWidget {

  final currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final _pageList = [MainPage(), WorkoutListPage(), SettingPage()];

    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (context, index, child) {
        return Scaffold(
          body: _pageList[index],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (i) => currentIndex.value = i,
            currentIndex: currentIndex.value,
            items: [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.home),
                title: Text('ホーム')
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.list),
                title: Text('履歴')
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.cog),
                title: Text('その他')
              )
            ],
          ),
        );
      },
    );
  }
}