part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashAnimating extends SplashState {
  final double animationProgress; // 0.0 to 1.0

  const SplashAnimating({this.animationProgress = 0.0});

  @override
  List<Object?> get props => [animationProgress];
}

class SplashComplete extends SplashState {
  const SplashComplete();
}
