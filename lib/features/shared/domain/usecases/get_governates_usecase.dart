import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:clinic_flow/features/shared/domain/entities/gorvernate.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../repositories/shared_repository.dart';

class GetGovernatesUseCase implements UseCase<List<Governate>, NoParams> {
  final SharedRepository repository;
  GetGovernatesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Governate>>> call(NoParams params) async {
    return await repository.getGovernates();
  }
}