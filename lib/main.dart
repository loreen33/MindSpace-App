import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart'; // Import the new Welcome Screen

void main() {
  runApp(const MindSpaceApp());
}

class MindSpaceApp extends StatelessWidget {
  const MindSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindSpace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF111827),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B5CF6),
          brightness: Brightness.dark,
        ),
      ),
      home: const WelcomeScreen(), // Set this as the new starting point!
    );
  }
}