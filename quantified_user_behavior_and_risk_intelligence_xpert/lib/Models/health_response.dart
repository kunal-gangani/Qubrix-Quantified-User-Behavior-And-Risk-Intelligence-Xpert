class HealthResponse {
  final String status;
  final String message;

  HealthResponse({required this.status, required this.message});

  factory HealthResponse.fromJson(Map<String, dynamic> json) {
    return HealthResponse(
      status: (json["status"] ?? "") as String,
      message: (json["message"] ?? "") as String,
    );
  }
}
