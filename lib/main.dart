import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CraveCartApp());
}

class CraveCartApp extends StatelessWidget {
  const CraveCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CraveCart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF5722), // Deep Coral / Orange
          primary: const Color(0xFFFF5722),
          secondary: const Color(0xFFFFAB40),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFFBF9F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF2D3142),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFF2D3142),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade100),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF5722),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
