import 'package:bossproject/states/add_post_teacher.dart';
import 'package:bossproject/states/authen.dart';
import 'package:bossproject/states/create_accunt.dart';
import 'package:bossproject/states/my_service_student.dart';
import 'package:bossproject/states/my_service_teacher.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount':(BuildContext context)=> CreateAccount(),
  '/myServiceTeacher':(BuildContext context)=>MyServiceTeacher(),
  '/myServiceStudent':(BuildContext context)=>MyServiceStudent(),
  '/addPostTeacher':(BuildContext context)=>AddPostTeacher(),
};
