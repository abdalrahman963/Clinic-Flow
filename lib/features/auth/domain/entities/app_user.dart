import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.status, // Made nullable since it's missing in the register response
    this.phone,  // Added from JSON
    this.age,    // Added from JSON
    this.gender, // Added from JSON
  });

  final int id;
  final String name;
  final String email;
  final String? status;
  final UserRole role;
  final String? phone;
  final int? age;
  final String? gender;

  @override
  List<Object?> get props => [id, name, email, status, role, phone, age, gender];
}

enum UserRole { doctor, patient, user } // Added 'user' to match the JSON response