class DownloadFileResponse {
  final List<int> content;
  final String filename;
  final String mimeType;

  DownloadFileResponse({
    required this.content,
    required this.filename,
    required this.mimeType,
  });

  factory DownloadFileResponse.fromJson(Map<String, dynamic> json) {
    return DownloadFileResponse(
      content: List<int>.from(json['content'].values),
      filename: json['filename'],
      mimeType: json['mimetype'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'filename': filename,
      'mimetype': mimeType,
    };
  }

  @override
  String toString() => 'DownloadFileResponse(content: $content, filename: $filename, mimeType: $mimeType)';
}
