import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/save_request.dart';
import '../../Services/api_service.dart';
import 'save_event.dart';
import 'save_state.dart';

class SaveBloc extends Bloc<SaveEvent, SaveState> {
  final ApiService apiService;

  SaveBloc({required this.apiService}) : super(const SaveInitial()) {
    on<SaveRequested>(_onSaveRequested);
  }

  Future<void> _onSaveRequested(
    SaveRequested event,
    Emitter<SaveState> emit,
  ) async {
    emit(const SaveLoading());
    try {
      final req = SaveRequest(
        riskScore: event.riskScore,
        riskLevel: event.riskLevel,
        analysis: event.analysis,
        timestamp: DateTime.now().toIso8601String(),
      );

      final res = await apiService.saveToNotion(req);

      if (!res.success) {
        emit(SaveFailure(res.message));
        return;
      }

      emit(SaveSuccess(message: res.message, notionPageId: res.notionPageId));
    } catch (e) {
      emit(SaveFailure(e.toString()));
    }
  }
}
