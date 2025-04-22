import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextFormField(decoration: const InputDecoration(labelText: "Name")),
            const SizedBox(height: 16),
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
              child: const Text("Register"),
            ),
            TextButton(
              onPressed: () => context.go('/auth/login'),
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
