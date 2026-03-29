import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../Utils/app_constants.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitial()) {
    on<SplashInitialized>(_onSplashInitialized);
    on<SplashAnimationTick>(_onAnimationTick);
  }

  Timer? _animationTimer;
  double _animationProgress = 0.0;
  static const int _animationFramesPerSecond = 60;
  late int _totalFrames;

  Future<void> _onSplashInitialized(
    SplashInitialized event,
    Emitter<SplashState> emit,
  ) async {
    // Calculate total frames needed for animation
    _totalFrames =
        (AppConstants.splashScreenDuration.inMilliseconds /
                1000 *
                _animationFramesPerSecond)
            .toInt();

    // Start animation loop
    _startAnimationLoop();
  }

  void _startAnimationLoop() {
    _animationTimer = Timer.periodic(
      Duration(milliseconds: 1000 ~/ _animationFramesPerSecond),
      (_) {
        add(const SplashAnimationTick());
      },
    );
  }

  Future<void> _onAnimationTick(
    SplashAnimationTick event,
    Emitter<SplashState> emit,
  ) async {
    _animationProgress += 1.0 / _totalFrames;

    if (_animationProgress >= 1.0) {
      _animationProgress = 1.0;
      _animationTimer?.cancel();
      emit(const SplashComplete());
    } else {
      emit(SplashAnimating(animationProgress: _animationProgress));
    }
  }

  @override
  Future<void> close() {
    _animationTimer?.cancel();
    return super.close();
  }
}
