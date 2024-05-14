part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => <Object>[];
}

class SignupRequested extends AuthEvent {
  const SignupRequested(
      {required this.name, required this.email, required this.password});
  final String name;
  final String email;
  final String password;
}

class LoginRequested extends AuthEvent {
  const LoginRequested({required this.email, required this.password});
  final String email;
  final String password;
}

class AppOnBoardingRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}
