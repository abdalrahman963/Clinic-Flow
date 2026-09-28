import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dashboard_stats.dart';
import '../repositories/doctor_repository.dart';

class GetDoctorDashboardUseCase implements UseCase<DashboardStats, NoParams> {
  GetDoctorDashboardUseCase(this.repository);

  final DoctorRepository repository;

  @override
  Future<Either<Failure, DashboardStats>> call(NoParams params) {
    return repository.getDashboardStats();
  }
}

