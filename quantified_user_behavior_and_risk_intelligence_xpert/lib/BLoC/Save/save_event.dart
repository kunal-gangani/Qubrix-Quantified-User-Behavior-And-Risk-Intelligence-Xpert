import 'package:equatable/equatable.dart';

abstract class SaveEvent extends Equatable {
  const SaveEvent();
  @override
  List<Object?> get props => [];
}

class SaveRequested extends SaveEvent {
  final int riskScore;
  final String riskLevel;
  final String analysis;

  const SaveRequested({
    required this.riskScore,
    required this.riskLevel,
    required this.analysis,
  });

  @override
  List<Object?> get props => [riskScore, riskLevel, analysis];
}
