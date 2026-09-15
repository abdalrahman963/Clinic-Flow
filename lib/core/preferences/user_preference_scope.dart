import '../../features/auth/domain/entities/app_user.dart';

/// Separates saved theme/locale per account role + user id.
abstract final class UserPreferenceScope {
  static const guest = 'guest';

  static String fromUser(AppUser user) {
    final prefix = switch (user.role) {
      UserRole.doctor => 'doctor',
      UserRole.patient || UserRole.user => 'patient',
    };
    return '${prefix}_${user.id}';
  }

  /// Driver / ambulance unit accounts (separate from patient/doctor scopes).
  static String driver(int unitOrUserId) => 'driver_$unitOrUserId';
}
