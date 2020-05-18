import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotAuthorizedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                alignment: Alignment.center,
                child: FaIcon(FontAwesomeIcons.running, size: 200, color: Colors.redAccent,),
              ),
              Container(
                height: 200,
                alignment: Alignment.center,
                child: FaIcon(FontAwesomeIcons.times, size: 200, color: Colors.black,),
              ),
            ],
          ),
          SizedBox(height: 20,),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'あなたの運動の記録が取得できません😭\n\n',
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: '設定',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                ),
                TextSpan(
                  text: ' → ',
                  style: DefaultTextStyle.of(context).style
                ),
                TextSpan(
                  text: 'ヘルスケア\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                ),
                TextSpan(
                  text: ' → ',
                  style: DefaultTextStyle.of(context).style
                ),
                TextSpan(
                  text: 'データアクセスとデバイス',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                ),
                TextSpan(
                  text: ' → ',
                  style: DefaultTextStyle.of(context).style
                ),
                TextSpan(
                  text: 'HASHIRU',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                ),
                TextSpan(
                  text: 'へ移動して\nすべてのカテゴリをオンにしてください',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                ),
              ]
            ),
          )
        ],
      ),
    );
  }
}