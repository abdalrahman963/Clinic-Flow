import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/appointment.dart';
import '../entities/dashboard_stats.dart';
import '../entities/doctor_profile.dart';

abstract class DoctorRepository {
  Future<Either<Failure, DoctorProfile>> getMyProfile();

  Future<Either<Failure, DashboardStats>> getDashboardStats();

  Future<Either<Failure, List<Appointment>>> getTodayAppointments();
}

