import 'package:clinic_flow/features/patient/patient_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../doctor/presentation/pages/doctor_root_page.dart';
import '../../../patient/presentation/pages/patient_root_page.dart';
import '../../domain/entities/app_user.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'login_page.dart';

class AuthGatePage extends StatelessWidget {
  const AuthGatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading || state is AuthInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthUnauthenticated) {
          return LoginPage(errorMessage: state.errorMessage);
        }

        final session = (state as AuthAuthenticated).session;
        if (session.user.role == UserRole.doctor) {
          return const DoctorRootPage();
        }
        return const PatientHomePage();
      },
    );
  }
}

