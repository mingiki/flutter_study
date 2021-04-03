import 'package:flutter/material.dart';
import 'package:instagram_two/constants/material_white89.dart';
import 'package:instagram_two/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  //widget 이 처음 실행하는게 아래 build이다.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : HomePage(),
      theme: ThemeData(
        primarySwatch: white89
      ),
    );
  }
}

