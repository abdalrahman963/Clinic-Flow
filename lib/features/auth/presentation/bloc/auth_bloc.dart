import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_cached_session_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart'; // Import the new UseCase
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.getCachedSessionUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.registerUseCase, // Inject it here
  }) : super(const AuthInitial()) {
    on<AuthAppStartedEvent>(_onStarted);
    on<AuthLoginSubmittedEvent>(_onLogin);
    on<AuthRegisterSubmittedEvent>(_onRegister); // Add the new event handler
    on<AuthLogoutRequestedEvent>(_onLogout);
  }

  final GetCachedSessionUseCase getCachedSessionUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUseCase; // Define it

  Future<void> _onStarted(AuthAppStartedEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await getCachedSessionUseCase(NoParams());
    result.fold(
      (failure) => emit(AuthUnauthenticated(errorMessage: failure.message)),
      (session) => session == null ? emit(const AuthUnauthenticated()) : emit(AuthAuthenticated(session)),
    );
  }

  Future<void> _onLogin(AuthLoginSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await loginUseCase(LoginParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(AuthUnauthenticated(errorMessage: failure.message)),
      (session) => emit(AuthAuthenticated(session)),
    );
  }

  // --- NEW: Register Handler ---
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
      (session) => emit(AuthAuthenticated(session)),
    );
  }

  Future<void> _onLogout(AuthLogoutRequestedEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    await logoutUseCase(NoParams());
    emit(const AuthUnauthenticated());
  }
}