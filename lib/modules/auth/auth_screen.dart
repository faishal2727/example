import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/auth/bloc/auth_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login to your account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
               TextField(
                controller: emailController..text = "fais@gmail.com",
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
              ),
               TextField(
                controller: passwordController..text = "fais12345",
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        AuthEvent.login(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
