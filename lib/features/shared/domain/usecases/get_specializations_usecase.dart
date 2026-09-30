import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/specialization.dart';
import '../repositories/shared_repository.dart';

class GetSpecializationsUseCase implements UseCase<List<Specialization>, NoParams> {
  final SharedRepository repository;
  GetSpecializationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Specialization>>> call(NoParams params) async {
    return await repository.getSpecializations();
  }
}