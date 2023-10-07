import 'package:flutter/material.dart';
import 'package:login/common/di.dart';
import 'package:login/modules/auth/auth_screen.dart';
import 'package:login/modules/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  registerInjection();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => getIt<AuthBloc>()..add(const AuthEvent.started()),
      ),
    ],
    child: InitialApp(),
  ));
}

class InitialApp extends StatelessWidget {
  const InitialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: BlocConsumer<AuthBloc, AuthState>(
        bloc: getIt<AuthBloc>(),
        listener: (context, state) {
          print("state: $state");
          if (state.isLoading) {
           ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("login..."),
              ),
            );
          }

          if (state.error != "") {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: Text(state.error),
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state.isLogin) {
            print("adung 4 ${state.isLogin}");
            return HomeScreen(); // TODO: replace with home screen
          }

          return AuthScreen();
        },
      ),
    );
  }
}
