import 'package:clinic_flow/features/doctor/data/datasources/doctor_remote_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/entities/doctor_profile.dart';
import '../../domain/repositories/doctor_repository.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  DoctorRepositoryImpl({required this.remoteDataSource});

  final DoctorRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, DoctorProfile>> getMyProfile() async {
    try {
      final profile = await remoteDataSource.getMyProfile();
      return Right(profile);
    } on ServerException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(ServerFailure('Failed to load profile.'));
    }
  }

  @override
  Future<Either<Failure, DashboardStats>> getDashboardStats() async {
    try {
      final stats = await remoteDataSource.getDashboardStats();
      return Right(stats);
    } on ServerException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(ServerFailure('Failed to load dashboard.'));
    }
  }

  @override
  Future<Either<Failure, List<Appointment>>> getTodayAppointments() async {
    try {
      final items = await remoteDataSource.getTodayAppointments();
      return Right(items);
    } on ServerException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(ServerFailure('Failed to load appointments.'));
    }
  }
}

