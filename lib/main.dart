import 'package:flutter/material.dart';
import 'package:gti_forum/home.dart';

void main() {
  runApp(GtiForum());
}

class GtiForum extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GTI Forum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
