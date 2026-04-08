class SaveRequest {
  final int riskScore;
  final String riskLevel; // Low/Medium/High
  final String analysis;
  final String timestamp; // ISO-8601

  SaveRequest({
    required this.riskScore,
    required this.riskLevel,
    required this.analysis,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    "risk_score": riskScore,
    "risk_level": riskLevel,
    "analysis": analysis,
    "timestamp": timestamp,
  };
}
