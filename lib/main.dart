import 'package:flutter/material.dart';
import 'package:flutter_garbage_classification/util/common.dart';

import 'main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    MaterialColor MainColor = MaterialColor(0xFF00d060, color);
    return MaterialApp(
      title: '环保卫士',
      theme: ThemeData(
        primarySwatch: MainColor,
      ),
      home:MainPage(),
    );
  }
}

