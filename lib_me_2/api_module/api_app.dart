import 'package:flutter/material.dart';
import 'product_detail_screen.dart';
import 'product_screen.dart';

class ApiApp extends StatelessWidget {
  const ApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: ProductScreen(),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(builder: (_) => ProductScreen());
          case "/detail":
            return MaterialPageRoute(
              builder: (_) => ProductDetailScreen(),
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
