part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  SignUpEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });
}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}

class CheckSessionAvailability extends AuthEvent {}

class LogoutEvent extends AuthEvent {}