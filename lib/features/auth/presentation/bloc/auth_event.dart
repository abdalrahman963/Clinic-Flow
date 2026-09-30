import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthAppStartedEvent extends AuthEvent {
  const AuthAppStartedEvent();
}

class AuthLoginSubmittedEvent extends AuthEvent {
  const AuthLoginSubmittedEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

// --- NEW: Register Event ---
class AuthRegisterSubmittedEvent extends AuthEvent {
  const AuthRegisterSubmittedEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.phone,
    required this.age,
    required this.gender,
  });

  final String name;
  final String email;
  final String password;
  final String role;
  final String phone;
  final int age;
  final String gender;

  @override
  List<Object?> get props => [name, email, password, role, phone, age, gender];
}

class AuthLogoutRequestedEvent extends AuthEvent {
  const AuthLogoutRequestedEvent();
}