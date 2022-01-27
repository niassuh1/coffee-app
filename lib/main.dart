import 'package:capulus/constants.dart';
import 'package:capulus/views/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Capulus',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: primaryColor,
        fontFamily: 'Inter',
      ),
      home: HomeScreen(),
    );
  }
}
