import 'package:flutter/material.dart';

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
        child: Center(
          child: Text('ほげ'),
        ),
      ),
    );
  }
}