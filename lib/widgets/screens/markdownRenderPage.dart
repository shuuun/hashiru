import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownRenderPage extends StatelessWidget {

  final String title;
  final String filePath;

  MarkdownRenderPage({this.title, this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: FutureBuilder(
          future: rootBundle.loadString(filePath),
          builder: (context, snapshot) {
            return Markdown(data: snapshot.data,);
          },
        ),
      ),
    );
  }
}