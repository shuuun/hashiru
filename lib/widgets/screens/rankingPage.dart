import 'package:flutter/material.dart';

import 'package:hashiru/widgets/components/rankingListTile.dart';

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ランキング'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 30,
          itemBuilder: (context, index) {
            return RankingListTile(rank: index + 1, name: 'ランニング太郎', totalDistance: 100.00);
          },
        ),
      ),
    );
  }
}