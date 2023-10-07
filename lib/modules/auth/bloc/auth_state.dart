part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLogin,
    @Default(false) bool isLoading,
    @Default("") String error,
  }) = _AuthState;
}
