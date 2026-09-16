import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:clinic_flow/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

import '../entities/auth_session.dart';


class GetCachedSessionUseCase implements UseCase<AuthSession?, NoParams> {
  GetCachedSessionUseCase(this.repository);
  final AuthRepository repository;

  @override
  Future<Either<Failure, AuthSession?>> call(NoParams params) {
    return repository.getCachedSession();
  }
}

