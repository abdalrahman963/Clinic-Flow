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

class AuthLogoutRequestedEvent extends AuthEvent {
  const AuthLogoutRequestedEvent();
}

