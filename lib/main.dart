import 'package:flutter/material.dart';
import 'screens/registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryPink = Color(0xFFE9AFC1);
    const lightPink = Color(0xFFF9EEF2);
    const darkText = Color(0xFF4A3F45);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Registration',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: lightPink,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryPink,
          primary: primaryPink,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: lightPink,
          foregroundColor: darkText,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE7D7DD)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: primaryPink, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryPink,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      home: const RegistrationScreen(),
    );
  }
}