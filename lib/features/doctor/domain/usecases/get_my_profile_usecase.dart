import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/doctor_profile.dart';
import '../repositories/doctor_repository.dart';

class GetMyDoctorProfileUseCase implements UseCase<DoctorProfile, NoParams> {
  GetMyDoctorProfileUseCase(this.repository);

  final DoctorRepository repository;

  @override
  Future<Either<Failure, DoctorProfile>> call(NoParams params) {
    return repository.getMyProfile();
  }
}

