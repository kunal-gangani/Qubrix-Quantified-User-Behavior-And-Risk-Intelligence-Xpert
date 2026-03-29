import 'package:equatable/equatable.dart';

import '../../Models/analyze_response.dart';

abstract class AnalyzeState extends Equatable {
  const AnalyzeState();
}

class AnalyzeInitial extends AnalyzeState {
  const AnalyzeInitial();

  @override
  List<Object?> get props => [];
}

class AnalyzeLoading extends AnalyzeState {
  const AnalyzeLoading();

  @override
  List<Object?> get props => [];
}

class AnalyzeSuccess extends AnalyzeState {
  final AnalyzeResponse data;

  const AnalyzeSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class AnalyzeFailure extends AnalyzeState {
  final String message;

  const AnalyzeFailure(this.message);

  @override
  List<Object?> get props => [message];
}
