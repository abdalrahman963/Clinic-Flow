import '../../domain/entities/app_user.dart';

class AppUserModel extends AppUser {
  const AppUserModel({
    required super.id,
    required super.name,
    required super.email,
    super.status, // Nullable
    required super.role,
    super.phone,
    super.age,
    super.gender,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    final name = (json['name'] ?? '').toString();
    final email = (json['email'] ?? '').toString();
    final roleRaw = (json['role'] ?? json['type'] ?? json['user_type'] ?? '').toString();

    final role = _parseRole(roleRaw, name: name, email: email);

    return AppUserModel(
      id: (json['id'] is num) ? (json['id'] as num).toInt() : int.tryParse('${json['id']}') ?? 0,
      name: name.isEmpty ? 'User' : name,
      email: email,
      status: json['status']?.toString(), // Safely handles null from API[cite: 7]
      role: role,
      phone: json['phone']?.toString(),
      age: (json['age'] is num) ? (json['age'] as num).toInt() : int.tryParse('${json['age']}'),
      gender: json['gender']?.toString(),
    );
  }
}

UserRole _parseRole(String raw, {required String name, required String email}) {
  final v = raw.toLowerCase().trim();
  if (v == 'doctor' || v == 'dr' || v == 'physician') return UserRole.doctor;
  if (v == 'patient') return UserRole.patient;
  if (v == 'user') return UserRole.user; // Added logic for "user"

  final normalizedName = name.toLowerCase().trim();
  if (normalizedName.startsWith('dr ') || normalizedName.startsWith('dr.')) return UserRole.doctor;
  if (email.toLowerCase().contains('doctor')) return UserRole.doctor;

  return UserRole.user; // Default fallback to user
}