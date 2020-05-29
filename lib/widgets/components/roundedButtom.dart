import 'dart:async';

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  final String text;
  final bool enabled;
  final FutureOr Function() onPressed;
  RoundedButton({@required this.text, this.enabled = true, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.redAccent,
      disabledColor: Colors.grey[400],
      onPressed: enabled ? onPressed : null,
      child: Container(
        width: 200,
        height: 44,
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18),),
      )
    );
  }
}