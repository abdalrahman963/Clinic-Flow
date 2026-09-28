import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/doctor_dashboard_bloc.dart';
import '../../bloc/doctor_dashboard_state.dart';

class DoctorScheduleTab extends StatelessWidget {
  const DoctorScheduleTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(title: const Text('Schedule')),
      body: BlocBuilder<DoctorDashboardBloc, DoctorDashboardState>(
        builder: (context, state) {
          if (state is DoctorDashboardLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.appointments.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final a = state.appointments[i];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(blurRadius: 16, offset: Offset(0, 8), color: Color(0x14000000)),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFFE2E8F0),
                        child: Icon(Icons.person, color: Color(0xFF475569)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              a.patientName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${a.startIso} - ${a.endIso}',
                              style: const TextStyle(color: Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      ),
                      FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF0284C7),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Text('Start'),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Load dashboard first.'));
        },
      ),
    );
  }
}

