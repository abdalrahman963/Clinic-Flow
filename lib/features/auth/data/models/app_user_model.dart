import '../../domain/entities/app_user.dart';

class AppUserModel extends AppUser {
  const AppUserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.status,
    required super.role,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    final name = (json['name'] ?? '').toString();
    final email = (json['email'] ?? '').toString();
    final roleRaw = (json['role'] ?? json['type'] ?? json['user_type'] ?? '').toString();

    // Backend sample doesn't include role, so we infer safely:
    // - If backend provides role/type/user_type, we use it
    // - Else: "Dr" prefix or email contains "doctor" -> doctor, otherwise patient
    final role = _parseRole(roleRaw, name: name, email: email);

    return AppUserModel(
      id: (json['id'] is num) ? (json['id'] as num).toInt() : int.tryParse('${json['id']}') ?? 0,
      name: name.isEmpty ? 'User' : name,
      email: email,
      status: (json['status'] ?? 'active').toString(),
      role: role,
    );
  }
}

UserRole _parseRole(String raw, {required String name, required String email}) {
  final v = raw.toLowerCase().trim();
  if (v == 'doctor' || v == 'dr' || v == 'physician') return UserRole.doctor;
  if (v == 'patient' || v == 'user') return UserRole.patient;

  final normalizedName = name.toLowerCase().trim();
  if (normalizedName.startsWith('dr ') || normalizedName.startsWith('dr.')) return UserRole.doctor;
  if (email.toLowerCase().contains('doctor')) return UserRole.doctor;

  return UserRole.patient;
}

