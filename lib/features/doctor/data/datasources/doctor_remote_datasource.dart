import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_config.dart';
import '../models/appointment_model.dart';
import '../models/dashboard_stats_model.dart';
import '../models/doctor_profile_model.dart';

abstract class DoctorRemoteDataSource {
  Future<DoctorProfileModel> getMyProfile();
  Future<DashboardStatsModel> getDashboardStats();
  Future<List<AppointmentModel>> getTodayAppointments();
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  DoctorRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<DoctorProfileModel> getMyProfile() async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/doctor/me');
    final res = await client.get(uri, headers: _headers());
    if (res.statusCode != 200) throw ServerException();
    final jsonMap = json.decode(res.body) as Map<String, dynamic>;
    return DoctorProfileModel.fromJson(jsonMap);
  }

  @override
  Future<DashboardStatsModel> getDashboardStats() async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/doctor/dashboard');
    final res = await client.get(uri, headers: _headers());
    if (res.statusCode != 200) throw ServerException();
    final jsonMap = json.decode(res.body) as Map<String, dynamic>;
    return DashboardStatsModel.fromJson(jsonMap);
  }

  @override
  Future<List<AppointmentModel>> getTodayAppointments() async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/doctor/appointments/today');
    final res = await client.get(uri, headers: _headers());
    if (res.statusCode != 200) throw ServerException();
    final decoded = json.decode(res.body);
    final list = (decoded is List) ? decoded : (decoded['items'] as List? ?? const []);
    return list.map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, String> _headers() => const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
}

