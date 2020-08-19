import 'package:android/screen/auth/login.dart';
import 'package:android/screen/auth/signup.dart';
import 'package:flutter/material.dart';
//import 'package:android/screen/auth/login.dart';
//import 'package:android/screen/auth/signup.dart';
import 'file:///C:/Users/shash/OneDrive/Desktop/flutterProjects/android/lib/controller/waiting.dart';
import 'file:///C:/Users/shash/OneDrive/Desktop/flutterProjects/android/lib/screen/dashBoard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => SignupPage(),
        '/Dash': (BuildContext context) => DashBoard(),
        '/login': (BuildContext context) => LoginPage()
      },
      home: WaitingScreen(),
      theme: ThemeData(fontFamily: "Montserrat"),
    );
  }
}
