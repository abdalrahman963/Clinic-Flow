import 'package:clinic_flow/features/shared/domain/entities/gorvernate.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/specialization.dart';
import '../../domain/repositories/shared_repository.dart';
import '../datasources/shared_remote_data_source.dart';

class SharedRepositoryImpl implements SharedRepository {
  final SharedRemoteDataSource remoteDataSource;

  SharedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Governate>>> getGovernates() async {
    try {
      final governates = await remoteDataSource.getGovernates();
      return Right(governates);
    } on UnauthorizedException {
      // Repository purely catches exceptions now, no HTTP knowledge needed
      return const Left(UnauthorizedFailure()); 
    } on ServerException {
      return const Left(ServerFailure());
    } on CacheException {
      return const Left(CacheFailure());
    } catch (_) {
      return const Left(ServerFailure('An unexpected error occurred while loading governates.'));
    }
  }

  @override
  Future<Either<Failure, List<Specialization>>> getSpecializations() async {
    try {
      final specializations = await remoteDataSource.getSpecializations();
      return Right(specializations);
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure());
    } on ServerException {
      return const Left(ServerFailure());
    } on CacheException {
      return const Left(CacheFailure());
    } catch (_) {
      return const Left(ServerFailure('An unexpected error occurred while loading specializations.'));
    }
  }
}