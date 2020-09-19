import 'package:todo_list/views/HomeActivity.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue
    ),
     title: 'To-Do List',
    home: Home(),
  ));

}

