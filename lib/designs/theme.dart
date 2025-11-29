import 'package:flutter/material.dart';

final ThemeData lightModeTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'NanumGothic',
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.white,
  primaryColor: const Color(0xFF030213),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF030213),
    brightness: Brightness.light,
    surface: Colors.white,
    onSurface: const Color(0xFF252525),
    primary: const Color(0xFF030213),
    onPrimary: Colors.white,
    secondary: const Color(0xFFF1F5F9),
    onSecondary: const Color(0xFF030213),
    error: const Color(0xFFD4183D),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Color(0xFF030213),
    elevation: 0,
  ),
);

final ThemeData darkModeTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'NanumGothic',
  scaffoldBackgroundColor: const Color(0xFF252525),
  cardColor: const Color(0xFF252525),
  primaryColor: const Color(0xFFFAFAFA),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFAFAFA),
    brightness: Brightness.dark,
    surface: const Color(0xFF252525),
    onSurface: const Color(0xFFFAFAFA),
    primary: const Color(0xFFFAFAFA),
    onPrimary: const Color(0xFF333333),
    secondary: const Color(0xFF444444), // Approx dark secondary
    onSecondary: const Color(0xFFFAFAFA),
    error: const Color(0xFF7F1D1D), // Darker error
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF252525),
    foregroundColor: Color(0xFFFAFAFA),
    elevation: 0,
  ),
);
