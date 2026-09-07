import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../basic_module/color_provider.dart';
import '../basic_module/theme_provider.dart';
import 'api_app.dart';

class ApiAppProvider extends StatelessWidget {
  const ApiAppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ColorProvider()),
      ],
      child: ApiApp(),
    );
  }
}