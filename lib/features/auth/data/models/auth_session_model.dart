import '../../domain/entities/auth_session.dart';
import 'app_user_model.dart';

class AuthSessionModel extends AuthSession {
  const AuthSessionModel({
    required super.token,
    required super.tokenType,
    required super.user,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      token: (json['token'] ?? '').toString(),
      tokenType: (json['token_type'] ?? 'bearer').toString(),
      user: AppUserModel.fromJson((json['user'] as Map?)?.cast<String, dynamic>() ?? const {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'token_type': tokenType,
        'user': {
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'status': user.status,
          'role': user.role.name,
        },
      };
}

