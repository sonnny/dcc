import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import './decoder_source.dart';

class DCCSourceDark extends StatelessWidget {

@override Widget build(BuildContext context) {
return Scaffold(backgroundColor: Colors.teal[50],
  appBar: AppBar(title: Text('DCC Source Code')),
  body: Column(children:[Container(
    height: MediaQuery.of(context).size.height * 0.80,
    child: SyntaxView(
      code: decoder_source,
      syntax: Syntax.C,
      syntaxTheme: SyntaxTheme.monokaiSublime(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: true,
      expanded: true))]));}}
