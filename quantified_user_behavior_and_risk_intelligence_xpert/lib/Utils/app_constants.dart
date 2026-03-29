/// App-wide constants
class AppConstants {
  // API Configuration
  static const String apiBaseUrl = "https://qubrix-q5ai.onrender.com";
  static const String healthCheckEndpoint = "/health";
  static const String analyzeEndpoint = "/analyze";
  static const String saveEndpoint = "/save";

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration splashScreenDuration = Duration(seconds: 3);

  // Animation Durations
  static const Duration splashAnimationDuration = Duration(milliseconds: 2000);
  static const Duration navigationAnimationDuration = Duration(
    milliseconds: 300,
  );

  // Risk Score Thresholds
  static const int lowRiskThreshold = 33;
  static const int mediumRiskThreshold = 66;
  static const int highRiskThreshold = 100;

  // UI Dimensions
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;

  // Text Limits
  static const int maxRecommendations = 4;
  static const int minImageCount = 1;
  static const int maxImageCount = 1000;
  static const int minVoiceSeconds = 1;
  static const int maxVoiceSeconds = 300; // 5 minutes

  // App Metadata
  static const String appName = "QUBRIX";
  static const String appSubtitle = "Identity Risk Analyzer";
  static const String appVersion = "1.0.0";
}
