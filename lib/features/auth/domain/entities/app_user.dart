import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.role,
  });

  final int id;
  final String name;
  final String email;
  final String status;
  final UserRole role;

  @override
  List<Object?> get props => [id, name, email, status, role];
}

enum UserRole { doctor, patient }

