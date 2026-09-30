import 'package:clinic_flow/features/shared/presentation/bloc/shared_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'features/auth/presentation/pages/auth_gate_page.dart';
import 'injection_container.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';

void main() async {
  // Ensure Flutter bindings are initialized before doing async work in main
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize our Dependency Injection container
  await di.init();

  runApp(const AdvancedClinicApp());
}

class AdvancedClinicApp extends StatelessWidget {
  const AdvancedClinicApp({super.key});

 @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>()..add(const AuthAppStartedEvent()),
        ),
        // --- INJECT THE SHARED BLOC GLOBALLY ---
        BlocProvider<SharedBloc>(
          create: (_) => sl<SharedBloc>(),
        ),
        // ... (your other Blocs like LocationBloc or DoctorDashboardBloc)
      ],
      child: MaterialApp(
        title: 'Advanced Clinic',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Your theme settings
        ),
        home: const AuthGatePage(),
      ),
    );
  }
}