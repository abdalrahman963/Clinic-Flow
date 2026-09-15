import 'package:clinic_flow/features/location/data/repository/location_repository_impl.dart';
import 'package:clinic_flow/features/location/domain/repository/location_repository.dart';
import 'package:get_it/get_it.dart';

import 'features/location/data/datasources/location_remote_data_source.dart';

import 'features/location/domain/usecases/get_current_location_usecase.dart';
import 'features/location/presentation/bloc/location_bloc.dart';

final sl = GetIt.instance; // sl stands for Service Locator

Future<void> init() async {
  // ==========================================
  // Feature: Location
  // ==========================================

  // Bloc (Always use registerFactory for Blocs so you get a fresh instance if the UI is rebuilt)
  sl.registerFactory(() => LocationBloc(getCurrentLocationUseCase: sl()));

  // Use Cases (LazySingletons are only created when they are first requested)
  sl.registerLazySingleton(() => GetCurrentLocationUseCase(sl()));

  // Repository (Bind the abstract interface to the actual implementation)
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(),
  );
}