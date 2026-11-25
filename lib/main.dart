import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HologramApp());
}

class HologramApp extends StatelessWidget {
  const HologramApp({super.key});

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFF090811);
    const surface = Color(0xFF151321);
    const accent = Color(0xFFFF3D9A);
    return MaterialApp(
      title: 'HOLOGRAM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.dark,
          surface: surface,
        ),
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(
          backgroundColor: background,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Color(0xFF100E19),
          indicatorColor: Color(0x338B5CF6),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          ),
        ),
        fontFamily: 'Roboto',
      ),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) return const HomeScreen();
        return const AuthScreen();
      },
    );
  }
}
