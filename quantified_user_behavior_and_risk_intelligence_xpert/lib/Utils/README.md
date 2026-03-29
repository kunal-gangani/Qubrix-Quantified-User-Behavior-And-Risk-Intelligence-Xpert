// This file serves as an index and guide for the Utils package
//
// OVERVIEW:
// The Utils package contains centralized configuration and constants for the entire application.
// This ensures consistency across all screens and improves maintainability.
//
// ============================================================================
// FILES IN THIS PACKAGE:
// ============================================================================
//
// 1. app_colors.dart
//    - Contains all color constants used throughout the app
//    - Organized by category: Primary, Secondary, Accent, Risk Levels, Neutral, Status, etc.
//    - USAGE: import '../../Utils/app_colors.dart';
//    - EXAMPLE: Color myColor = AppColors.primary;
//
// 2. app_constants.dart
//    - Contains all app-wide constants (API endpoints, timeouts, dimensions, etc.)
//    - Organized by category: API Config, Timeouts, UI Dimensions, Text Limits, etc.
//    - USAGE: import '../../Utils/app_constants.dart';
//    - EXAMPLE: String apiUrl = AppConstants.apiBaseUrl;
//
// ============================================================================
// QUICK REFERENCE - COLOR USAGE:
// ============================================================================
//
// PRIMARY COLORS (Brand):
//   AppColors.primary           // Deep Purple (main brand color)
//   AppColors.primaryLight      // Light Purple
//   AppColors.primaryDark       // Dark Purple
//
// SECONDARY COLORS (Accent):
//   AppColors.secondary         // Cyan (accent)
//   AppColors.secondaryLight    // Light Cyan
//   AppColors.secondaryDark     // Dark Cyan
//
// ACCENT COLORS (Status/Action):
//   AppColors.accentGreen       // For positive actions
//   AppColors.accentOrange      // For warnings
//   AppColors.accentRed         // For errors
//
// RISK LEVEL COLORS (Data Visualization):
//   AppColors.riskLow           // Green
//   AppColors.riskMedium        // Amber/Yellow
//   AppColors.riskHigh          // Red
//
// NEUTRAL COLORS (Gray Scale):
//   AppColors.grey50 - grey900  // 50 is lightest, 900 is darkest
//   AppColors.white
//   AppColors.black
//
// BACKGROUND COLORS:
//   AppColors.bgPrimary         // Main background
//   AppColors.bgSecondary       // Secondary background
//   AppColors.bgCard            // Card background
//
// TEXT COLORS:
//   AppColors.textPrimary       // Main text color
//   AppColors.textSecondary     // Secondary text
//   AppColors.textTertiary      // Tertiary text
//   AppColors.textOnPrimary     // Text on primary color
//   AppColors.textOnSecondary   // Text on secondary color
//
// STATUS COLORS:
//   AppColors.success           // Green (for success states)
//   AppColors.warning           // Yellow (for warnings)
//   AppColors.error             // Red (for errors)
//   AppColors.info              // Blue (for info)
//
// ============================================================================
// HOW TO USE COLORS IN YOUR CODE:
// ============================================================================
//
// EXAMPLE 1: Simple Text Color
// ```dart
// Text(
//   'Hello World',
//   style: TextStyle(color: AppColors.textPrimary),
// )
// ```
//
// EXAMPLE 2: Container with Primary Color
// ```dart
// Container(
//   color: AppColors.primary,
//   child: Text('Button', style: TextStyle(color: AppColors.textOnPrimary)),
// )
// ```
//
// EXAMPLE 3: Risk Level Color (Dynamic)
// ```dart
// Color riskColor = riskScore > 66 ? AppColors.riskHigh : 
//                   riskScore > 33 ? AppColors.riskMedium : 
//                   AppColors.riskLow;
// ```
//
// EXAMPLE 4: Gradient Using Primary Colors
// ```dart
// Container(
//   decoration: BoxDecoration(
//     gradient: LinearGradient(
//       colors: [AppColors.primary, AppColors.primaryDark],
//     ),
//   ),
// )
// ```
//
// EXAMPLE 5: Card with Theme Colors
// ```dart
// Card(
//   color: AppColors.bgCard,
//   child: Container(
//     decoration: BoxDecoration(
//       border: Border(
//         left: BorderSide(color: AppColors.primary, width: 4),
//       ),
//     ),
//     child: Text('Card Content', style: TextStyle(color: AppColors.textPrimary)),
//   ),
// )
// ```
//
// ============================================================================
// CONSTANTS QUICK REFERENCE:
// ============================================================================
//
// API ENDPOINTS:
//   AppConstants.apiBaseUrl              // Base URL
//   AppConstants.healthCheckEndpoint     // /health
//   AppConstants.analyzeEndpoint         // /analyze
//   AppConstants.saveEndpoint            // /save
//
// TIMEOUTS:
//   AppConstants.apiTimeout              // 30 seconds
//   AppConstants.splashScreenDuration    // 3 seconds
//
// DURATIONS:
//   AppConstants.splashAnimationDuration      // 2000 ms
//   AppConstants.navigationAnimationDuration  // 300 ms
//
// RISK THRESHOLDS:
//   AppConstants.lowRiskThreshold    // 33
//   AppConstants.mediumRiskThreshold // 66
//   AppConstants.highRiskThreshold   // 100
//
// UI DIMENSIONS:
//   AppConstants.defaultPadding  // 16.0
//   AppConstants.smallPadding    // 8.0
//   AppConstants.largePadding    // 24.0
//   AppConstants.borderRadius    // 12.0
//
// ============================================================================
// COMMON PATTERNS:
// ============================================================================
//
// PATTERN 1: Status-based Color Selection
// ```dart
// Color _getStatusColor(MyState state) {
//   if (state is LoadingState) return AppColors.info;
//   if (state is SuccessState) return AppColors.success;
//   if (state is ErrorState) return AppColors.error;
//   return AppColors.grey500;
// }
// ```
//
// PATTERN 2: Risk Score Color
// ```dart
// Color _getRiskColor(int score) {
//   if (score <= AppConstants.lowRiskThreshold) return AppColors.riskLow;
//   if (score <= AppConstants.mediumRiskThreshold) return AppColors.riskMedium;
//   return AppColors.riskHigh;
// }
// ```
//
// PATTERN 3: Theme-aware Styling
// ```dart
// Text(
//   'Hello',
//   style: Theme.of(context).textTheme.titleMedium?.copyWith(
//     color: AppColors.primary,
//     fontWeight: FontWeight.bold,
//   ),
// )
// ```
//
// ============================================================================
// BEST PRACTICES:
// ============================================================================
//
// ✓ DO: Always use AppColors constants for colors
// ✓ DO: Use AppConstants for API endpoints and timeouts
// ✓ DO: Import at the top of your file
// ✓ DO: Use semantic color names (e.g., riskHigh instead of Color(0xFFEF4444))
// ✓ DO: Group related color usages
//
// ✗ DON'T: Hardcode colors in widgets
// ✗ DON'T: Use Color(0xFF...) directly
// ✗ DON'T: Create local color constants
// ✗ DON'T: Modify AppColors constants at runtime
//
// ============================================================================
// ADDING NEW COLORS:
// ============================================================================
//
// When you need a new color:
// 1. Add it to AppColors in app_colors.dart
// 2. Follow existing naming conventions
// 3. Group it with related colors
// 4. Add documentation comment
//
// Example:
// ```dart
// // Brand Colors
// static const Color brandPrimary = Color(0xFF7C3AED);
// static const Color brandSecondary = Color(0xFF00D9FF);
// ```
//
// ============================================================================
