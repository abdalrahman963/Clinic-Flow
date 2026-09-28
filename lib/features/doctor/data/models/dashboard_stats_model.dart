import '../../domain/entities/dashboard_stats.dart';

class DashboardStatsModel extends DashboardStats {
  const DashboardStatsModel({
    required super.completedToday,
    required super.pendingRequests,
    required super.nextSlotLabel,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      completedToday: (json['completedToday'] is num) ? (json['completedToday'] as num).toInt() : 0,
      pendingRequests: (json['pendingRequests'] is num) ? (json['pendingRequests'] as num).toInt() : 0,
      nextSlotLabel: (json['nextSlotLabel'] ?? '—').toString(),
    );
  }
}

