import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth_session.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthSession>> login({
    required String email,
    required String password,
  });

  // --- NEW: Register Method ---
  Future<Either<Failure, AuthSession>> register({
    required String name,
    required String email,
    required String password,
    required String role,
    required String phone,
    required int age,
    required String gender,
  });

  Future<Either<Failure, AuthSession?>> getCachedSession();

  Future<Either<Failure, void>> logout();
}