import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_cached_session_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.getCachedSessionUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(const AuthInitial()) {
    on<AuthAppStartedEvent>(_onStarted);
    on<AuthLoginSubmittedEvent>(_onLogin);
    on<AuthLogoutRequestedEvent>(_onLogout);
  }

  final GetCachedSessionUseCase getCachedSessionUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

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

  Future<void> _onLogout(AuthLogoutRequestedEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    await logoutUseCase(NoParams());
    emit(const AuthUnauthenticated());
  }
}

