import 'package:flutter/material.dart';
//import 'login_screen.dart';
//import 'home_screen.dart';
import 'persistant_nav_screen.dart';

class BasicApp extends StatelessWidget {
 const BasicApp({super.key});
  @override
  Widget build(BuildContext context) {
    final seedcolor=const Color.fromARGB(255, 16, 212, 42);

    return MaterialApp(
      home: MainScreen(),
      //home: HomeScreen(),
      //home: LoginScreen(),
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: seedcolor)
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(brightness:.dark,seedColor: seedcolor,surface:Colors.grey.shade900)
      )
    );
  }
}