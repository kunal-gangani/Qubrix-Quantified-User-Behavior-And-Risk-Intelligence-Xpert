class SaveResponse {
  final bool success;
  final String message;
  final String? notionPageId;

  SaveResponse({
    required this.success,
    required this.message,
    this.notionPageId,
  });

  factory SaveResponse.fromJson(Map<String, dynamic> json) {
    return SaveResponse(
      success: (json["success"] ?? false) as bool,
      message: (json["message"] ?? "") as String,
      notionPageId: (json["notion_page_id"] ?? json["notionPageId"]) as String?,
    );
  }
}
