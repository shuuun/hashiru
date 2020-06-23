import 'package:flutter/material.dart';

class DropDownButton extends StatelessWidget {
  final ValueNotifier<String> content;
  final Future Function() onPressed;

  DropDownButton({this.content, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 350,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(15)
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        onPressed: onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ValueListenableBuilder<String>(
              valueListenable: content,
              builder: (context, _content, child) {
                return Text(_content, textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),);
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_drop_down),
            )
          ],
        ),
      )
    );
  }
}