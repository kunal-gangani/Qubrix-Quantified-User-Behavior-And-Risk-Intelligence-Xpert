import 'package:equatable/equatable.dart';

abstract class AnalyzeEvent extends Equatable {
  const AnalyzeEvent();
}

class AnalyzeRequested extends AnalyzeEvent {
  final int imagesCount;
  final int voiceSeconds;
  final String socialPresence;

  const AnalyzeRequested({
    required this.imagesCount,
    required this.voiceSeconds,
    required this.socialPresence,
  });

  @override
  List<Object?> get props => [imagesCount, voiceSeconds, socialPresence];
}
