import 'package:flutter/material.dart';

class DoctorPatientsTab extends StatelessWidget {
  const DoctorPatientsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(title: const Text('Patients')),
      body: const Center(
        child: Text(
          'Patients',
          style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
        ),
      ),
    );
  }
}
