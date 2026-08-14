import 'package:flutter/material.dart';
import 'login_screen.dart';

class BasicApp extends StatelessWidget {
 const BasicApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: HomeScreen(),
      home: LoginScreen(),
    );
  }
}