import 'package:equatable/equatable.dart';

class HealthResponse extends Equatable {
  final String status;
  final String message;

  const HealthResponse({required this.status, required this.message});

  factory HealthResponse.fromJson(Map<String, dynamic> json) {
    return HealthResponse(
      status: (json["status"] ?? "") as String,
      message: (json["message"] ?? "") as String,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
