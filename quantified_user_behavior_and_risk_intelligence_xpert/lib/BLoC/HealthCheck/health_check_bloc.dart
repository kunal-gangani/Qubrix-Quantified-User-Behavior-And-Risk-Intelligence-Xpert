import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../Models/health_response.dart';
import '../../Services/api_service.dart';
part 'health_check_event.dart';
part 'health_check_state.dart';

class HealthCheckBloc extends Bloc<HealthCheckEvent, HealthCheckState> {
  final ApiService apiService;

  HealthCheckBloc({required this.apiService})
    : super(const HealthCheckInitial()) {
    on<HealthCheckRequested>(_onHealthCheckRequested);
  }

  Future<void> _onHealthCheckRequested(
    HealthCheckRequested event,
    Emitter<HealthCheckState> emit,
  ) async {
    emit(const HealthCheckLoading());

    try {
      final data = await apiService.healthCheck();
      emit(HealthCheckSuccess(data));
    } catch (e) {
      emit(HealthCheckFailure(e.toString()));
    }
  }
}
