import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_screen.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'color_provider.dart';
class BasicApp extends StatelessWidget {
  const BasicApp({super.key});

  @override
  Widget build(BuildContext context) {
    int index = context.watch<ColorProvider>().index;
    final seedColor = colorList[index];
    final darkColor = colorList[index];
    final myTextTheme = GoogleFonts.siemreapTextTheme();

    bool dark = context.watch<ThemeProvider>().dark;

    return MaterialApp(
      home: MainScreen(),
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
        textTheme: myTextTheme,
      ),
    );
  }
}

// class BasicApp extends StatelessWidget {
//   const BasicApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final seedColor = Colors.lime;
//     final darkColor = Colors.grey.shade900;
//     final myTextTheme = GoogleFonts.siemreapTextTheme();

//     return MaterialApp(
//       home: MainScreen(),
//       themeMode: .light,
//       theme: ThemeData(
//         brightness: .light,
//         colorScheme: .fromSeed(seedColor: seedColor, surface: Colors.white),
//         textTheme: myTextTheme,
//       ),
//       darkTheme: ThemeData(
//         brightness: .dark,
//         colorScheme: .fromSeed(
//           brightness: .dark,
//           seedColor: darkColor,
//           surface: Colors.grey.shade900,
//         ),
//         textTheme: myTextTheme,
//       ),
//     );
//   }
// }
