import 'package:equatable/equatable.dart';

class DownloadFileResponse extends Equatable {
  final List<int> content;
  final String filename;
  final String mimeType;

  const DownloadFileResponse({
    required this.content,
    required this.filename,
    required this.mimeType,
  });

  factory DownloadFileResponse.fromJson(Map json) {
    final content = switch (json['content']) {
      final List list => List<int>.from(list.map((e) => e.toInt())),
      final Map map => List<int>.from(map.values.map((e) => e.toInt())),
      _ => throw Exception('Invalid type for content: ${json['content'].runtimeType}'),
    };

    return DownloadFileResponse(
      content: content,
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

  @override
  List<Object?> get props => [content, filename, mimeType];
}
