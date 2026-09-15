import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:clinic_flow/features/location/domain/entities/location.dart';
import 'package:clinic_flow/features/location/domain/repository/location_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

class GetCurrentLocationUseCase implements UseCase<Location, NoParams> {
  final LocationRepository repository;

  GetCurrentLocationUseCase(this.repository);

  // By overriding 'call', this class acts like a function
  @override
  Future<Either<Failure, Location>> call(NoParams params) async {
    return await repository.getCurrentLocation();
  }
}