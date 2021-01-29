import 'package:bossproject/utility/my_style.dart';
import 'package:flutter/material.dart';

class MyServiceStudent extends StatefulWidget {
  @override
  _MyServiceStudentState createState() => _MyServiceStudentState();
}

class _MyServiceStudentState extends State<MyServiceStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().bgColor,
        title: Text('Student'),
      ),drawer: Drawer(child: MyStyle().buildSignOut(context),),
    );
  }
}
