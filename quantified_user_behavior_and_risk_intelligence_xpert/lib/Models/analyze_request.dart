class AnalyzeRequest {
  final int imagesCount;
  final int voiceSeconds;
  final String socialPresence;

  AnalyzeRequest({
    required this.imagesCount,
    required this.voiceSeconds,
    required this.socialPresence,
  });

  Map<String, dynamic> toJson() {
    return {
      "images_count": imagesCount,
      "voice_seconds": voiceSeconds,
      "social_presence": socialPresence,
    };
  }
}
