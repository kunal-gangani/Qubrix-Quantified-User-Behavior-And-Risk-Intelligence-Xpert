import 'package:bloc/bloc.dart';

import '../../Models/analyze_request.dart';
import '../../Services/api_service.dart';
import 'analyze_event.dart';
import 'analyze_state.dart';

class AnalyzeBloc extends Bloc<AnalyzeEvent, AnalyzeState> {
  final ApiService apiService;

  AnalyzeBloc({required this.apiService}) : super(const AnalyzeInitial()) {
    on<AnalyzeRequested>(_onAnalyzeRequested);
  }

  Future<void> _onAnalyzeRequested(
    AnalyzeRequested event,
    Emitter<AnalyzeState> emit,
  ) async {
    emit(const AnalyzeLoading());

    try {
      final request = AnalyzeRequest(
        imagesCount: event.imagesCount,
        voiceSeconds: event.voiceSeconds,
        socialPresence: event.socialPresence,
      );

      final response = await apiService.analyzeRisk(request);
      emit(AnalyzeSuccess(response));
    } catch (e) {
      emit(AnalyzeFailure("Error: ${e.toString()}"));
    }
  }
}
