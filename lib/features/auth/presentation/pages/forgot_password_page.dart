import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Enter your email"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // kirim email reset password
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Reset link sent to your email')),
                );
              },
              child: const Text("Send Reset Link"),
            ),
            TextButton(
              onPressed: () => context.go('/auth/login'),
              child: const Text("Back to Login"),
            ),
          ],
        ),
      ),
    );
  }
}
