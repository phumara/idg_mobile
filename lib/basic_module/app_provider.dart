import 'package:flutter/material.dart';
import 'basic_app.dart';
import 'theme_provider.dart';
import 'package:provider/provider.dart';
import 'color_provider.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ColorProvider()),
      ],
      child: BasicApp(),
    );
  }
}
