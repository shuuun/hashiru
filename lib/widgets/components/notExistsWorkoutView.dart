import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hashiru/widgets/components/roundedButtom.dart';

class NotExistsWorkoutView extends StatelessWidget {

  final Future<void> Function() onRefresh;
  NotExistsWorkoutView({@required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(child: FaIcon(FontAwesomeIcons.running, color: Colors.grey[400], size: 100,),),
                  Expanded(child: FaIcon(FontAwesomeIcons.running, color: Colors.grey, size: 100,),),
                  Expanded(child: FaIcon(FontAwesomeIcons.running, color: Colors.black54, size: 100,),),
                  Expanded(child: FaIcon(FontAwesomeIcons.running, color: Colors.black87, size: 100,),)
                ],
              ),
              SizedBox(height: 30,),
              Text('走った記録がありません😭', style: TextStyle(fontSize: 24),),
              Text('HASHIRE!', style: TextStyle(color: Colors.redAccent, fontSize: 30),),
              SizedBox(height: 20),
              RoundedButton(text: 'データを再取得する', onPressed: onRefresh),
              Expanded(child: Container(),)
            ],
          ),
        )
      )
    );
  }
}