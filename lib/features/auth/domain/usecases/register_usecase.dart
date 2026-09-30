import 'package:clinic_flow/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth_session.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, AuthSession>> call(RegisterParams params) async {
    return await repository.register(
      name: params.name,
      email: params.email,
      password: params.password,
      role: params.role,
      phone: params.phone,
      age: params.age,
      gender: params.gender,
    );
  }
}

// A helper class to pass data from the UI to the UseCase
class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String role;
  final String phone;
  final int age;
  final String gender;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.phone,
    required this.age,
    required this.gender,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        role,
        phone,
        age,
        gender,
      ];
}