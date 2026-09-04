import 'package:clinic_flow/core/error/failures.dart';
import 'package:clinic_flow/features/location/domain/entities/location.dart';
import 'package:dartz/dartz.dart'; // Since you have dartz in pubspec

abstract class LocationRepository {
  Future<Either<Failure, Location>> getCurrentLocation();
  Future<Either<Failure, bool>> checkAndRequestPermissions();
}
