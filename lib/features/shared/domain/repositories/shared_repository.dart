import 'package:clinic_flow/features/shared/domain/entities/gorvernate.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/specialization.dart';

abstract class SharedRepository {
  Future<Either<Failure, List<Governate>>> getGovernates();
  Future<Either<Failure, List<Specialization>>> getSpecializations();
}