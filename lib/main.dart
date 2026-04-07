import 'package:flutter/material.dart';
import 'package:medical_irkutsk/core/theme/theme.dart';
import 'package:medical_irkutsk/features/user_greeting/presentation/greeting_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const GreetingScreen(),
    );
  }
}
