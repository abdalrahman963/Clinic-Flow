import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:clinic_flow/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';


class LogoutUseCase implements UseCase<void, NoParams> {
  LogoutUseCase(this.repository);
  final AuthRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.logout();
  }
}

