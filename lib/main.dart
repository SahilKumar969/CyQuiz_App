import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(CyberQuizApp());
}

class CyberQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CyberQuiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
