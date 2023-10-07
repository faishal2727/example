import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:login/data/repository/auth_repository.dart';
import 'package:login/modules/auth/bloc/auth_bloc.dart';

GetIt getIt = GetIt.instance;

void registerInjection() {
  // dependencies
  getIt.registerSingleton<Dio>(Dio());

  // Repository
  getIt.registerSingleton(AuthRepostory());

  // bloc
  getIt.registerSingleton<AuthBloc>(AuthBloc());
}