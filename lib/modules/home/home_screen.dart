import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/auth/bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthBloc>()..add(AuthEvent.logout());
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
