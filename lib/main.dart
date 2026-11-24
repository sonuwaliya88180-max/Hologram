import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';

void main() => runApp(const HologramApp());

class HologramApp extends StatelessWidget {
  const HologramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOLOGRAM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD62976)),
        scaffoldBackgroundColor: const Color(0xFFF8F7FB),
        fontFamily: 'Roboto',
      ),
      home: const AuthScreen(),
    );
  }
}
