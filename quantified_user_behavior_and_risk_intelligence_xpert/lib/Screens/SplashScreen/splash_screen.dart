import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLoC/Splash/splash_bloc.dart';
import '../../Utils/app_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(const SplashInitialized()),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashComplete) {
          Navigator.of(context).pushReplacementNamed('/connectivity');
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1612),
        body: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            double progress = state is SplashAnimating
                ? state.animationProgress
                : 1.0;

            return Stack(
              children: [
                _buildBackground(),
                _buildAccentLine(context),
                _buildContent(progress),
                _buildVersion(progress),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.2),
          radius: 0.85,
          colors: [Color(0xFF2A1F0E), Color(0xFF1A1612), Color(0xFF0F0D0A)],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildAccentLine(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 1,
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Color(0x40C99222), Colors.transparent],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(double progress) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLogo(progress),
          const SizedBox(height: 32),
          _buildTitle(progress),
          const SizedBox(height: 48),
          _buildLoader(progress),
        ],
      ),
    );
  }

  Widget _buildLogo(double progress) {
    // Logo appears between 0% - 55%
    double logoProgress = (progress / 0.55).clamp(0.0, 1.0);
    double logoScale = 0.5 + (logoProgress * 0.5);
    double logoOpacity = logoProgress;

    return Opacity(
      opacity: logoOpacity,
      child: Transform.scale(
        scale: logoScale,
        child: Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1612),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC99222).withOpacity(0.4),
                blurRadius: 30,
                spreadRadius: 8,
              ),
              BoxShadow(
                color: const Color(0xFF00D9FF).withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset('lib/Media/logo.png'),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(double progress) {
    // Title appears between 30% - 75%
    double titleProgress = ((progress - 0.3) / 0.45).clamp(0.0, 1.0);
    double titleOffset = (1.0 - titleProgress) * 20;
    double titleOpacity = titleProgress;

    return Transform.translate(
      offset: Offset(0, titleOffset),
      child: Opacity(
        opacity: titleOpacity,
        child: Column(
          children: [
            Text(
              AppConstants.appName,
              style: GoogleFonts.orbitron(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppConstants.appSubtitle,
              style: GoogleFonts.orbitron(
                fontSize: 14,
                color: const Color(0xFFC99222),
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoader(double progress) {
    // Loader appears between 60% - 100%
    double loaderProgress = ((progress - 0.6) / 0.4).clamp(0.0, 1.0);
    double loaderOpacity = loaderProgress;
    double rotation = loaderProgress * 2 * 3.14159;

    return Opacity(
      opacity: loaderOpacity,
      child: Column(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Transform.rotate(
              angle: rotation,
              child: CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF00D9FF),
                ),
                strokeWidth: 3,
                value: loaderProgress,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Powered by AI',
            style: GoogleFonts.orbitron(
              fontSize: 11,
              color: Colors.white.withOpacity(0.7),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersion(double progress) {
    double versionOpacity = (progress * 2).clamp(0.0, 1.0);

    return Positioned(
      bottom: 24,
      left: 0,
      right: 0,
      child: Opacity(
        opacity: versionOpacity,
        child: Center(
          child: Text(
            'v${AppConstants.appVersion}',
            style: GoogleFonts.orbitron(
              fontSize: 10,
              color: Colors.white.withOpacity(0.5),
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
