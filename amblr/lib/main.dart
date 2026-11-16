import 'package:flutter/material.dart';
import 'pages/frontpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      home: const Frontpage(),
    );
  }
}
