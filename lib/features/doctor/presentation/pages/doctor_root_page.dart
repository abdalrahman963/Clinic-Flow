import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/doctor_dashboard_bloc.dart';
import '../bloc/doctor_dashboard_event.dart';
import 'tabs/doctor_dashboard_tab.dart';
import 'tabs/doctor_patients_tab.dart';
import 'tabs/doctor_profile_tab.dart';
import 'tabs/doctor_schedule_tab.dart';

class DoctorRootPage extends StatefulWidget {
  const DoctorRootPage({super.key});

  @override
  State<DoctorRootPage> createState() => _DoctorRootPageState();
}

class _DoctorRootPageState extends State<DoctorRootPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DoctorDashboardBloc>()..add(const LoadDoctorDashboardEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: IndexedStack(
            index: _index,
            children: const [
              DoctorDashboardTab(),
              DoctorScheduleTab(),
              DoctorPatientsTab(),
              DoctorProfileTab(),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(Icons.calendar_month),
              label: 'Schedule',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline),
              selectedIcon: Icon(Icons.people),
              label: 'Patients',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

