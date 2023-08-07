import 'package:flutter/material.dart';
import 'package:to_do/screens/to_do_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(
      ),
      debugShowCheckedModeBanner: false,
      home: TodoList(),
    );
  }
}

