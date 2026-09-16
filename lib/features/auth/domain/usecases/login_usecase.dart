import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:clinic_flow/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';

import '../entities/auth_session.dart';


class LoginUseCase implements UseCase<AuthSession, LoginParams> {
  LoginUseCase(this.repository);
  final AuthRepository repository;

  @override
  Future<Either<Failure, AuthSession>> call(LoginParams params) {
    return repository.login(email: params.email, password: params.password);
  }
}

class LoginParams extends Equatable {
  const LoginParams({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

