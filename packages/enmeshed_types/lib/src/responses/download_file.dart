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
    return DownloadFileResponse(
      content:
          json['content'].runtimeType == (List<int>) ? List<int>.from(json['content']) : List<int>.from(json['content'].values.map((x) => x.toInt())),
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
