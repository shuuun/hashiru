import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SelectWorkoutMonthPicker {
  Future<String> showPicker(BuildContext context, List<String> contents, String defaultValue) async {
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
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black54))),
              child: FlatButton(
                child: Text('決定', style: TextStyle(color: Colors.red[400]),),
                onPressed: () {
                  Navigator.of(context).pop(_selected);
                },
              ),
            ),
            Container(
              height: 300,
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