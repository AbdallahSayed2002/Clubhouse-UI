import 'package:clubhouse_ui/constants.dart';
import 'package:clubhouse_ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Clubhouse UI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: kBackgroundColor),
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: Colors.white,
        hintColor: kAccentColorGreen,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      home: HomeScreen(),
    );
  }
}
