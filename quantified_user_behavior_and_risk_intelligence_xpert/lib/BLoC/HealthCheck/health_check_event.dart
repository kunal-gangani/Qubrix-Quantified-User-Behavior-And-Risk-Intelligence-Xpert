part of 'health_check_bloc.dart';

abstract class HealthCheckEvent extends Equatable {
  const HealthCheckEvent();

  @override
  List<Object?> get props => [];
}

class HealthCheckRequested extends HealthCheckEvent {
  const HealthCheckRequested();
}
