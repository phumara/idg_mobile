import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../basic_module/theme_provider.dart';
import 'package:provider/provider.dart';
import '../basic_module/color_provider.dart';
import 'api_main_screen.dart';
import 'product_detail_screen.dart';
import 'dummy_product_detail_screen.dart';

class ApiApp extends StatelessWidget {
  const ApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    int index = context.watch<ColorProvider>().index;
    final seedColor = colorList[index];
    final darkColor = colorList[index];
    final myTextTheme = GoogleFonts.siemreapTextTheme();

    bool dark = context.watch<ThemeProvider>().dark;

    return MaterialApp(
      themeMode: dark ? .dark : .light,
      theme: ThemeData(
        brightness: .light,
        colorScheme: .fromSeed(seedColor: seedColor, surface: Colors.white),
        textTheme: myTextTheme,
      ),
      darkTheme: ThemeData(
        brightness: .dark,
        colorScheme: .fromSeed(
          brightness: .dark,
          seedColor: darkColor,
          surface: Colors.grey.shade900,
        ),
        textTheme: myTextTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(builder: (_) => ApiMainScreen());
          case "/detail":
            return MaterialPageRoute(
              builder: (_) => ProductDetailScreen(),
              settings: settings,
            );
          case "/dummy-detail":
            return MaterialPageRoute(
              builder: (_) => DummyProductDetailScreen(),
              settings: settings,
            );
          default:
            return MaterialPageRoute(
              builder: (_) => Center(child: Text("Screen Not Found")),
            );
        }
      },
    );
  }
}
