import 'package:clinic_flow/features/location/data/datasources/location_remote_data_source.dart';
import 'package:clinic_flow/features/location/domain/entities/location.dart';
import 'package:clinic_flow/features/location/domain/repository/location_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';


class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;

  LocationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, bool>> checkAndRequestPermissions() async {
    try {
      final status = await Permission.locationWhenInUse.status;
      
      if (status.isGranted) {
        return const Right(true);
      }

      final requestStatus = await Permission.locationWhenInUse.request();
      
      if (requestStatus.isGranted) {
        return const Right(true);
      } else if (requestStatus.isPermanentlyDenied) {
        return const Left(LocationPermissionFailure('Location permissions are permanently denied. Please enable them in settings.'));
      } else {
        return const Left(LocationPermissionFailure('Location permissions were denied.'));
      }
    } catch (e) {
      return const Left(ServerFailure('An error occurred while checking permissions.'));
    }
  }

  @override
  Future<Either<Failure, Location>> getCurrentLocation() async {
    try {
      // First, ensure permissions are granted before trying to get location
      final permissionResult = await checkAndRequestPermissions();
      
      return permissionResult.fold(
        (failure) => Left(failure), // If permission failed, return the failure
        (_) async {
          // If permission is granted, fetch the actual coordinates
          final locationModel = await remoteDataSource.getCurrentPosition();
          return Right(locationModel);
        },
      );
    } on LocationDisabledException {
      return const Left(LocationDisabledFailure());
    } on LocationPermissionException {
      return const Left(LocationPermissionFailure());
    } catch (e) {
      return const Left(ServerFailure('Failed to get current location.'));
    }
  }
}