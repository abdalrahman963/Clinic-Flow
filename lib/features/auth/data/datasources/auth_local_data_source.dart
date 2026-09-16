import 'dart:convert';

import 'package:clinic_flow/features/auth/data/models/auth_session_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



abstract class AuthLocalDataSource {
  Future<void> cacheSession(AuthSessionModel session);
  Future<AuthSessionModel?> getCachedSession();
  Future<void> clear();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({required this.prefs});

  final SharedPreferences prefs;

  static const _kSession = 'auth_session';

  @override
  Future<void> cacheSession(AuthSessionModel session) async {
    await prefs.setString(_kSession, json.encode(session.toJson()));
  }

  @override
  Future<AuthSessionModel?> getCachedSession() async {
    final raw = prefs.getString(_kSession);
    if (raw == null || raw.isEmpty) return null;
    final jsonMap = json.decode(raw) as Map<String, dynamic>;
    return AuthSessionModel.fromJson(jsonMap);
  }

  @override
  Future<void> clear() async {
    await prefs.remove(_kSession);
  }
}

