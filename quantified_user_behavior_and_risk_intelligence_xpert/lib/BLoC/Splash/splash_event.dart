part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class SplashInitialized extends SplashEvent {
  const SplashInitialized();
}

class SplashAnimationTick extends SplashEvent {
  const SplashAnimationTick();
}
