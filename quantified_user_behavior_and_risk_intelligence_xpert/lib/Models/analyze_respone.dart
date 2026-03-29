class AnalyzeResponse {
  final int riskScore;
  final String riskLevel;
  final String analysis;
  final String impersonationMessage;
  final List<String> recommendations;
  final String userWarning;

  AnalyzeResponse({
    required this.riskScore,
    required this.riskLevel,
    required this.analysis,
    required this.impersonationMessage,
    required this.recommendations,
    required this.userWarning,
  });

  factory AnalyzeResponse.fromJson(Map<String, dynamic> json) {
    return AnalyzeResponse(
      riskScore: (json["risk_score"] ?? 0) as int,
      riskLevel: (json["risk_level"] ?? "") as String,
      analysis: (json["analysis"] ?? "") as String,
      impersonationMessage: (json["impersonation_message"] ?? "") as String,
      recommendations: ((json["recommendations"] ?? []) as List)
          .map((e) => e.toString())
          .toList(),
      userWarning: (json["user_warning"] ?? "") as String,
    );
  }
}
