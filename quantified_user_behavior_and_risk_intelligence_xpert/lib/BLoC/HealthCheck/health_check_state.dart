part of 'health_check_bloc.dart';

abstract class HealthCheckState extends Equatable {
  const HealthCheckState();

  @override
  List<Object?> get props => [];
}

class HealthCheckInitial extends HealthCheckState {
  const HealthCheckInitial();
}

class HealthCheckLoading extends HealthCheckState {
  const HealthCheckLoading();
}

class HealthCheckSuccess extends HealthCheckState {
  final HealthResponse healthResponse;

  const HealthCheckSuccess(this.healthResponse);

  @override
  List<Object?> get props => [healthResponse];
}

class HealthCheckFailure extends HealthCheckState {
  final String error;

  const HealthCheckFailure(this.error);

  @override
  List<Object?> get props => [error];
}
