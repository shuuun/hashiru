import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SelectWorkoutMonthPicker {
  Future<String> showPicker(BuildContext context, { List<String> contents, String defaultValue }) async {
    String _selected = defaultValue;
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
                child: Text('選択', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.redAccent, fontWeight: FontWeight.bold),),
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
                      child: Text(content),
                    )
                ],
                scrollController: FixedExtentScrollController(initialItem: contents.indexOf(defaultValue)),
              ),
            )
          ],
        );
      }
    );
    
    return result ?? _selected;
  }
}