import 'package:equatable/equatable.dart';

import '../contents/contents.dart';
import 'local_response_source.dart';

class LocalResponseDTO extends Equatable {
  final String createdAt;
  final Response content;
  final LocalResponseSourceDTO? source;

  const LocalResponseDTO({required this.createdAt, required this.content, this.source});

  factory LocalResponseDTO.fromJson(Map json) {
    return LocalResponseDTO(
      createdAt: json['createdAt'],
      content: Response.fromJson(json['content']),
      source: json['source'] != null ? LocalResponseSourceDTO.fromJson(json['source']) : null,
    );
  }

  static LocalResponseDTO? fromJsonNullable(Map? json) => json != null ? LocalResponseDTO.fromJson(json) : null;

  Map<String, dynamic> toJson() => {'createdAt': createdAt, 'content': content.toJson(), if (source != null) 'source': source?.toJson()};

  @override
  List<Object?> get props => [createdAt, content, source];
}
