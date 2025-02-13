import 'package:equatable/equatable.dart';

class DownloadFileResponse extends Equatable {
  final List<int> content;
  final String filename;
  final String mimeType;

  const DownloadFileResponse({required this.content, required this.filename, required this.mimeType});

  factory DownloadFileResponse.fromJson(Map json) {
    return DownloadFileResponse(
      content: List<int>.from(json['content'].map((e) => e.toInt())),
      filename: json['filename'],
      mimeType: json['mimetype'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'content': content, 'filename': filename, 'mimetype': mimeType};
  }

  @override
  List<Object?> get props => [content, filename, mimeType];
}
