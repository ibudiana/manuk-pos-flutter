import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextFormField(
                decoration: const InputDecoration(labelText: "Email")),
            const SizedBox(height: 16),
            TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password")),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.go('/home');
              },
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () => context.go('/auth/forgot-password'),
              child: const Text("Forgot Password?"),
            ),
            TextButton(
              onPressed: () => context.go('/auth/signup'),
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
