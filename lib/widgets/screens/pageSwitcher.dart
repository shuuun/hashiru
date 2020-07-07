import 'package:flutter/material.dart';

import 'package:hashiru/widgets/screens/workoutListPage.dart';
import 'package:hashiru/widgets/screens/mainPage.dart';
import 'package:hashiru/widgets/screens/settingPage.dart';
import 'package:hashiru/widgets/screens/rankingPage.dart';

class PageSwitcher extends StatelessWidget {

  final currentIndex = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    /// Pageを追加する時ははここに追加
    final _pageList = [ MainPage(), RankingPage(), WorkoutListPage(), SettingPage() ];

    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (context, index, child) {
        return Scaffold(
          body: _pageList[index],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (i) => currentIndex.value = i,
            currentIndex: currentIndex.value,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('ホーム')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_list_numbered),
                title: Text('ランキング')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                title: Text('履歴')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('その他')
              )
            ],
          ),
        );
      },
    );
  }
}