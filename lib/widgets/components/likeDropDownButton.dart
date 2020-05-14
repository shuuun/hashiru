import 'package:flutter/material.dart';

class LikeDropDownButton extends StatelessWidget {
  final ValueNotifier<String> content;
  final Future Function() onPressed;

  LikeDropDownButton({this.content, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(15)
        ),
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