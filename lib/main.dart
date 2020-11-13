import 'package:fieldmonitor/ui/project_list_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monitorlibrary/data/user.dart';
import 'package:monitorlibrary/functions.dart';

void main() async {
  runApp(MyApp());
  await Firebase.initializeApp();
  pp('🥦🥦🥦🥦🥦 Firebase has been initialized 🥦🥦🥦🥦');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProjectListMain(FIELD_MONITOR),
    );
  }
}
