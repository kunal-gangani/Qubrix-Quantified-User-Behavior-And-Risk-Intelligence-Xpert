import 'package:equatable/equatable.dart';

class AnalyzeResponse extends Equatable {
  final double riskScore;
  final String riskLevel;
  final String analysis;
  final String impersonationMessage;
  final List<String> recommendations;
  final String userWarning;

  const AnalyzeResponse({
    required this.riskScore,
    required this.riskLevel,
    required this.analysis,
    required this.impersonationMessage,
    required this.recommendations,
    required this.userWarning,
  });

  factory AnalyzeResponse.fromJson(Map<String, dynamic> json) {
    final dynamic rawScore = json["riskScore"] ?? json["risk_score"];

    return AnalyzeResponse(
      riskScore: (rawScore as num?)?.toDouble() ?? 0.0,
      riskLevel: (json["riskLevel"] ?? json["risk_level"] ?? "") as String,
      analysis: (json["analysis"] ?? "") as String,
      impersonationMessage:
          (json["impersonationMessage"] ?? json["impersonation_message"] ?? "")
              as String,
      recommendations: ((json["recommendations"] ?? []) as List)
          .map((e) => e.toString())
          .toList(),
      userWarning:
          (json["userWarning"] ?? json["user_warning"] ?? "") as String,
    );
  }

  @override
  List<Object?> get props => [
    riskScore,
    riskLevel,
    analysis,
    impersonationMessage,
    recommendations,
    userWarning,
  ];
}
