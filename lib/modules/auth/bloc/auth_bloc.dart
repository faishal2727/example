// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/common/di.dart';
import 'package:login/common/uri.dart';
import 'package:login/data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<_Started>((event, emit) async {
      // check if user is logged in
      final isLog = await getIt.get<AuthRepostory>().isLoggedIn();
      debugPrint("adung 2 $isLog");

      if (isLog) {
        emit(state.copyWith(isLogin: true));

        return;
      }

      emit(state.copyWith(isLogin: false));
    });

    on<_Login>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      // login user
      final dio = getIt.get<Dio>();

      try {
        final result = await dio.post("$endpoint/login", data: {
          "email": event.email,
          "password": event.password,
        });

        // save token to storage
        await getIt
            .get<AuthRepostory>()
            .setToken(result.data["loginResult"]["token"]);

        debugPrint("CEKK ${result.data["loginResult"]["token"]}");

        final cek = await getIt.get<AuthRepostory>().isLoggedIn();
        if (cek == null) {
          debugPrint("Tidak Ada $cek");
        }
        debugPrint("ADA $cek");
        emit(state.copyWith(isLogin: true, isLoading: false));
      } catch (e) {
        if (e is DioException) {
          log("err :${e.response!.data}");
        }

        emit(state.copyWith(error: e.toString(), isLoading: false));
      }
    });

    on<_Logout>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await getIt.get<AuthRepostory>().removeToken();

      emit(state.copyWith(isLogin: false, isLoading: false));
    });
  }
}
