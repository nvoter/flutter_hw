import 'package:flutter/material.dart';
import './screens/components/main_screen.dart';
import './utils/theme.dart';
import './utils/dependencies_manager.dart';

void main() {
  setup();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cat Tinder',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: MainScreen(),
    );
  }
}
