import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'auth_screen.dart';

class PhoneOtpScreen extends StatefulWidget {
  const PhoneOtpScreen({super.key});

  @override
  State<PhoneOtpScreen> createState() => _PhoneOtpScreenState();
}

class _PhoneOtpScreenState extends State<PhoneOtpScreen> {
  final phoneController = TextEditingController();
  final codeController = TextEditingController();
  String? verificationId;
  bool sending = false;
  bool verifying = false;
  String? errorText;

  @override
  void dispose() {
    phoneController.dispose();
    codeController.dispose();
    super.dispose();
  }

  Future<void> sendCode() async {
    final phone = phoneController.text.trim();
    if (!RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(phone)) {
      setState(() => errorText = 'Enter phone with country code, e.g. +919876543210');
      return;
    }
    setState(() { sending = true; errorText = null; });
    try {
      await AuthService.instance.sendPhoneOtp(
        phoneNumber: phone,
        onCodeSent: (id, token) {
          if (!mounted) return;
          setState(() { verificationId = id; sending = false; });
        },
        onError: (error) {
          if (!mounted) return;
          setState(() { sending = false; errorText = error.message ?? error.code; });
        },
        onAutoVerified: (credential) async {
          try {
            await FirebaseAuth.instance.signInWithCredential(credential);
            if (mounted) Navigator.of(context).popUntil((route) => route.isFirst);
          } on FirebaseAuthException catch (e) {
            if (mounted) setState(() => errorText = e.message ?? e.code);
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      if (mounted) setState(() { sending = false; errorText = e.message ?? e.code; });
    } catch (e) {
      if (mounted) setState(() { sending = false; errorText = 'Could not send OTP. Check Firebase setup.'; });
    }
  }

  Future<void> verifyCode() async {
    if (verificationId == null || codeController.text.trim().length != 6) {
      setState(() => errorText = 'Enter the 6-digit OTP.');
      return;
    }
    setState(() { verifying = true; errorText = null; });
    try {
      await AuthService.instance.verifyPhoneOtp(
        verificationId: verificationId!,
        smsCode: codeController.text,
      );
      if (mounted) Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      if (mounted) setState(() { verifying = false; errorText = e.message ?? e.code; });
    } catch (_) {
      if (mounted) setState(() { verifying = false; errorText = 'OTP verification failed. Please try again.'; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: hologramGradient),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(26)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.sms_outlined, size: 48, color: Color(0xFFD62976)),
                    const SizedBox(height: 14),
                    const Text('Mobile OTP Login', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    const Text('Enter your number with country code to receive a verification code.',
                      textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
                    const SizedBox(height: 22),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Mobile number (e.g. +919876543210)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone_android),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (verificationId != null) ...[
                      TextField(
                        controller: codeController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: const InputDecoration(labelText: '6-digit OTP', border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (errorText != null) ...[
                      Text(errorText!, style: const TextStyle(color: Colors.red, fontSize: 12)),
                      const SizedBox(height: 10),
                    ],
                    DecoratedBox(
                      decoration: BoxDecoration(gradient: hologramGradient, borderRadius: BorderRadius.circular(12)),
                      child: ElevatedButton(
                        onPressed: sending || verifying ? null : verificationId == null ? sendCode : verifyCode,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent,
                          foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15)),
                        child: Text(sending ? 'SENDING...' : verifying ? 'VERIFYING...' : verificationId == null ? 'SEND OTP' : 'VERIFY OTP'),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back to Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
