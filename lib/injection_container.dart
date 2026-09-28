import 'package:clinic_flow/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clinic_flow/features/auth/domain/repository/auth_repository.dart';
import 'package:clinic_flow/features/doctor/data/datasources/doctor_remote_datasource.dart';
import 'package:clinic_flow/features/location/data/repository/location_repository_impl.dart';
import 'package:clinic_flow/features/location/domain/repository/location_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';

import 'features/auth/domain/usecases/get_cached_session_usecase.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/doctor/data/repositories/doctor_repository_impl.dart';
import 'features/doctor/domain/repositories/doctor_repository.dart';
import 'features/doctor/domain/usecases/get_doctor_dashboard_usecase.dart';
import 'features/doctor/domain/usecases/get_my_profile_usecase.dart';
import 'features/doctor/domain/usecases/get_today_appointments_usecase.dart';
import 'features/doctor/presentation/bloc/doctor_dashboard_bloc.dart';
import 'features/location/data/datasources/location_remote_data_source.dart';

import 'features/location/domain/usecases/get_current_location_usecase.dart';
import 'features/location/presentation/bloc/location_bloc.dart';

final sl = GetIt.instance; // sl stands for Service Locator

Future<void> init() async {
  // External
  sl.registerLazySingleton<http.Client>(() => http.Client());
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

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

  // ==========================================
  // Feature: Doctor
  // ==========================================

  sl.registerFactory(
    () => DoctorDashboardBloc(
      getDoctorDashboardUseCase: sl(),
      getTodayAppointmentsUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetDoctorDashboardUseCase(sl()));
  sl.registerLazySingleton(() => GetTodayAppointmentsUseCase(sl()));
  sl.registerLazySingleton(() => GetMyDoctorProfileUseCase(sl()));

  sl.registerLazySingleton<DoctorRepository>(
    () => DoctorRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<DoctorRemoteDataSource>(
    () => DoctorRemoteDataSourceImpl(client: sl()),
  );

  // ==========================================
  // Feature: Auth
  // ==========================================

  sl.registerFactory(
    () => AuthBloc(
      getCachedSessionUseCase: sl(),
      loginUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedSessionUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remote: sl(), local: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(prefs: sl()),
  );
}