import 'package:equatable/equatable.dart';

import 'app_user.dart';

class AuthSession extends Equatable {
  const AuthSession({
    required this.token,
    required this.tokenType,
    required this.user,
  });

  final String token;
  final String tokenType;
  final AppUser user;

  @override
  List<Object?> get props => [token, tokenType, user];
}

