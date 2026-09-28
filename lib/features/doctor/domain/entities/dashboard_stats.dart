import 'package:equatable/equatable.dart';

class DashboardStats extends Equatable {
  const DashboardStats({
    required this.completedToday,
    required this.pendingRequests,
    required this.nextSlotLabel,
  });

  final int completedToday;
  final int pendingRequests;
  final String nextSlotLabel;

  @override
  List<Object?> get props => [completedToday, pendingRequests, nextSlotLabel];
}

