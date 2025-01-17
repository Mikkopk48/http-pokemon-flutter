import 'package:flutter/material.dart';
import 'package:http_pokemon_flutter/theme/app_theme.dart';
import 'package:http_pokemon_flutter/presentation/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      home: const HomeScreen()
    );
  }
}