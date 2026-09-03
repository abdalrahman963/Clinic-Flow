import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// Specific failures we can show to the UI
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'A server error occurred.']);
}

class LocationPermissionFailure extends Failure {
  const LocationPermissionFailure([super.message = 'Location permissions were denied.']);
}

class LocationDisabledFailure extends Failure {
  const LocationDisabledFailure([super.message = 'Location services are disabled.']);
}