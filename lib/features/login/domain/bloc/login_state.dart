import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default(false) bool isNotAdmin,
    @Default(false) bool isFinished,
  }) = _LoginState;
}
