import 'package:equatable/equatable.dart';

abstract class SaveState extends Equatable {
  const SaveState();
  @override
  List<Object?> get props => [];
}

class SaveInitial extends SaveState {
  const SaveInitial();
}

class SaveLoading extends SaveState {
  const SaveLoading();
}

class SaveSuccess extends SaveState {
  final String message;
  final String? notionPageId;

  const SaveSuccess({required this.message, this.notionPageId});

  @override
  List<Object?> get props => [message, notionPageId];
}

class SaveFailure extends SaveState {
  final String error;

  const SaveFailure(this.error);

  @override
  List<Object?> get props => [error];
}
