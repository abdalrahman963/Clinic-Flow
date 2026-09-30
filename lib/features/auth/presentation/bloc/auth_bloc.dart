import 'dart:developer'; // <-- 1. Add this import

import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_cached_session_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.getCachedSessionUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.registerUseCase,
  }) : super(const AuthInitial()) {
    on<AuthAppStartedEvent>(_onStarted);
    on<AuthLoginSubmittedEvent>(_onLogin);
    on<AuthRegisterSubmittedEvent>(_onRegister);
    on<AuthLogoutRequestedEvent>(_onLogout);
  }

  final GetCachedSessionUseCase getCachedSessionUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUseCase;

  Future<void> _onStarted(AuthAppStartedEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await getCachedSessionUseCase(NoParams());
    result.fold(
      (failure) => emit(AuthUnauthenticated(errorMessage: failure.message)),
      (session) {
        if (session == null) {
          emit(const AuthUnauthenticated());
        } else {
          // --- 2. Print token on app startup ---
          log('\n========================================\nAPP STARTED TOKEN:\nBearer ${session.token}\n========================================', name: 'AUTH');
          emit(AuthAuthenticated(session));
        }
      },
    );
  }

  Future<void> _onLogin(AuthLoginSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await loginUseCase(LoginParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(AuthUnauthenticated(errorMessage: failure.message)),
      (session) {
        // --- 2. Print token on Login ---
        log('\n========================================\nLOGIN SUCCESS TOKEN:\nBearer ${session.token}\n========================================', name: 'AUTH');
        emit(AuthAuthenticated(session));
      },
    );
  }

  Future<void> _onRegister(AuthRegisterSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await registerUseCase(RegisterParams(
      name: event.name,
      email: event.email,
      password: event.password,
      role: event.role,
      phone: event.phone,
      age: event.age,
      gender: event.gender,
    ));
    
    result.fold(
      (failure) => emit(AuthUnauthenticated(errorMessage: failure.message)),
      (session) {
        // --- 2. Print token on Registration ---
        log('\n========================================\nREGISTER SUCCESS TOKEN:\nBearer ${session.token}\n========================================', name: 'AUTH');
        emit(AuthAuthenticated(session));
      },
    );
  }

  Future<void> _onLogout(AuthLogoutRequestedEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    await logoutUseCase(NoParams());
    log('User Logged Out. Token Cleared.', name: 'AUTH');
    emit(const AuthUnauthenticated());
  }
}