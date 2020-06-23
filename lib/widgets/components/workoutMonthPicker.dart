import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WorkoutMonthPicker {
  Future<String> showPicker(BuildContext context, { @required List<String> contents, String defaultValue }) async {
    var _selected = defaultValue;
    final result = await showModalBottomSheet<String>(
      context: context, 
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 44,
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(_selected),
                child: Text('決定', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.redAccent, fontWeight: FontWeight.bold),),
              ),
            ),
            Container(
              height: 1,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black38))),
            ),
            Container(
              height: 250,
              child: CupertinoPicker(
                itemExtent: 40,
                onSelectedItemChanged: (v) {
                  _selected = contents[v];
                },
                children: [
                  for (var content in contents) 
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(content, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    )
                ],
                scrollController: FixedExtentScrollController(initialItem: defaultValue == '' ? 0 : contents.indexOf(defaultValue)),
              ),
            )
          ],
        );
      }
    );
    
    return result ?? _selected;
  }
}