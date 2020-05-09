import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:hashiru/blocs/runBloc.dart';

import 'package:hashiru/widgets/components/donutGraph.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
      ..addListener(() {
      });
  }
  
  @override
  Widget build(BuildContext context) {
    final ranBloc = Provider.of<RunBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('HASHIRU'),),
      floatingActionButton: FloatingActionButton(onPressed: () => ranBloc.getRunDistance(month: '4')),
      body: SafeArea(
        child: Center(
          child: Consumer<RunBloc>(
            builder: (context, ran, child) {
              return DonutGraph(percentage: ran.runPercentage, trackColor: Colors.grey[300], completedColor: Colors.redAccent);
            },
          )
        )
      ),
    );
  }
}