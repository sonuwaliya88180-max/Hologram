import 'package:flutter/material.dart';

const hologramGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFEDA75), Color(0xFFFA7E1E), Color(0xFFD62976), Color(0xFF962FBF), Color(0xFF4F5BD5)],
);

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool obscurePassword = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void submit() {
    if (emailController.text.trim().isEmpty || passwordController.text.isEmpty ||
        (!isLogin && nameController.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields.')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('UI ready. Firebase authentication will be connected next.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: const BoxDecoration(gradient: hologramGradient)),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .18),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withValues(alpha: .45)),
                      ),
                      child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 42),
                    ),
                    const SizedBox(height: 14),
                    const Text('HOLOGRAM', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900, letterSpacing: 3)),
                    const SizedBox(height: 7),
                    const Text('Your World. Your Identity. Your Connection.', textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .15), blurRadius: 28, offset: const Offset(0, 12))]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(isLogin ? 'Welcome back' : 'Create account',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: Color(0xFF202033))),
                          const SizedBox(height: 6),
                          Text(isLogin ? 'Login to continue your journey' : 'Join the HOLOGRAM community',
                            textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                          const SizedBox(height: 24),
                          if (!isLogin) ...[
                            _field(nameController, 'Full name', Icons.person_outline, textCapitalization: TextCapitalization.words),
                            const SizedBox(height: 14),
                          ],
                          _field(emailController, 'Email or mobile number', Icons.alternate_email_rounded),
                          const SizedBox(height: 14),
                          TextField(
                            controller: passwordController,
                            obscureText: obscurePassword,
                            decoration: _decoration('Password', Icons.lock_outline_rounded).copyWith(
                              suffixIcon: IconButton(
                                onPressed: () => setState(() => obscurePassword = !obscurePassword),
                                icon: Icon(obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                              ),
                            ),
                          ),
                          if (isLogin) ...[
                            const SizedBox(height: 10),
                            Align(alignment: Alignment.centerRight,
                              child: TextButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Password reset will be enabled with Firebase.'))),
                                child: const Text('Forgot password?'))),
                          ],
                          const SizedBox(height: 12),
                          DecoratedBox(
                            decoration: BoxDecoration(gradient: hologramGradient, borderRadius: BorderRadius.circular(14)),
                            child: ElevatedButton(
                              onPressed: submit,
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent,
                                foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                              child: Text(isLogin ? 'LOGIN' : 'CREATE ACCOUNT',
                                style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.2)),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Row(children: const [
                            Expanded(child: Divider()), Padding(padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('OR', style: TextStyle(color: Colors.black45, fontSize: 11))), Expanded(child: Divider()),
                          ]),
                          const SizedBox(height: 14),
                          OutlinedButton.icon(
                            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Google sign-in will be connected later.'))),
                            icon: const Icon(Icons.g_mobiledata_rounded, size: 28),
                            label: const Text('Continue with Google'),
                            style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFF252538),
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              side: const BorderSide(color: Color(0xFFE6E6EC)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                          ),
                          const SizedBox(height: 18),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(isLogin ? "Don't have an account? " : 'Already have an account? ',
                              style: const TextStyle(color: Colors.black54, fontSize: 13)),
                            GestureDetector(
                              onTap: () => setState(() => isLogin = !isLogin),
                              child: Text(isLogin ? 'Sign up' : 'Login',
                                style: const TextStyle(color: Color(0xFFB12A91), fontWeight: FontWeight.w800, fontSize: 13)),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text('By continuing, you agree to our Terms & Privacy Policy.',
                      textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 11)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(TextEditingController controller, String label, IconData icon,
      {TextCapitalization textCapitalization = TextCapitalization.none}) {
    return TextField(
      controller: controller,
      textCapitalization: textCapitalization,
      decoration: _decoration(label, icon),
    );
  }

  InputDecoration _decoration(String label, IconData icon) => InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: const Color(0xFF8D8D9C)),
    filled: true,
    fillColor: const Color(0xFFF7F7FA),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFECECF2))),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFB12A91), width: 1.5)),
  );
}
