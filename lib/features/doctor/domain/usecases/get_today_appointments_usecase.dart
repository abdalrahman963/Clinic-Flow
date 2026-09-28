import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/appointment.dart';
import '../repositories/doctor_repository.dart';

class GetTodayAppointmentsUseCase implements UseCase<List<Appointment>, NoParams> {
  GetTodayAppointmentsUseCase(this.repository);

  final DoctorRepository repository;

  @override
  Future<Either<Failure, List<Appointment>>> call(NoParams params) {
    return repository.getTodayAppointments();
  }
}

