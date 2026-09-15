import 'package:clinic_flow/dashboard_temp.dart';
import 'package:flutter/material.dart';
import 'package:clinic_flow/core/localization/l10n/app_localizations.dart';
import 'injection_container.dart' as di;

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize our Dependency Injection container
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinic Flow',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}
