import 'package:clinic_flow/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_session.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remote,
    required this.local,
  });

  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  @override
  Future<Either<Failure, AuthSession>> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await remote.login(email: email, password: password);
      await local.cacheSession(session);
      return Right(session);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } on ServerException {
      return const Left(ServerFailure('Server error.'));
    } catch (_) {
      return const Left(ServerFailure('Login failed.'));
    }
  }

  @override
  Future<Either<Failure, AuthSession?>> getCachedSession() async {
    try {
      final session = await local.getCachedSession();
      return Right(session);
    } catch (_) {
      return const Left(ServerFailure('Failed to read session.'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final cached = await local.getCachedSession();
      final token = cached?.token;
      if (token != null && token.isNotEmpty) {
        await remote.logout(token: token);
      }
      await local.clear();
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure('Failed to logout.'));
    }
  }
  @override
  Future<Either<Failure, AuthSession>> register({
    required String name,
    required String email,
    required String password,
    required String role,
    required String phone,
    required int age,
    required String gender,
  }) async {
    try {
      final session = await remote.register(
        name: name,
        email: email,
        password: password,
        role: role,
        phone: phone,
        age: age,
        gender: gender,
      );
      
      // We explicitly save the token to local storage so the user is instantly logged in
      await local.cacheSession(session);
      
      return Right(session);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } on ServerException {
      return const Left(ServerFailure('Server error.'));
    } catch (_) {
      return const Left(ServerFailure('Registration failed.'));
    }
  }
}

