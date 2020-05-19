import 'dart:async';

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  final String text;
  final FutureOr Function() onPressed;
  RoundedButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      fillColor: Colors.redAccent,
      onPressed: onPressed,
      child: Container(
        width: 200,
        height: 44,
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18),),
      )
    );
  }
}