import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'auth_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOLOGRAM', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            onPressed: () async => AuthService.instance.signOut(),
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.auto_awesome_rounded, size: 64, color: Color(0xFFD62976)),
              const SizedBox(height: 16),
              const Text('Welcome to HOLOGRAM', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(user?.displayName ?? user?.phoneNumber ?? user?.email ?? 'Creator',
                style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 18),
              const Text('You are signed in. Your social feed is the next build milestone.',
                textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 22),
              const Text('Your World. Your Identity. Your Connection.',
                textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFB12A91))),
            ],
          ),
        ),
      ),
    );
  }
}
