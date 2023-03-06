import '../contents/contents.dart';

class LocalResponseSourceDTO {
  final String type;
  final String reference;

  LocalResponseSourceDTO({
    required this.type,
    required this.reference,
  });

  factory LocalResponseSourceDTO.fromJson(Map<String, dynamic> json) {
    return LocalResponseSourceDTO(
      type: json['type'],
      reference: json['reference'],
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'reference': reference,
      };

  @override
  String toString() => 'LocalResponseSourceDTO(type: $type, reference: $reference)';
}

class LocalResponseDTO {
  final String createdAt;
  final Response content;
  final LocalResponseSourceDTO? source;

  LocalResponseDTO({
    required this.createdAt,
    required this.content,
    this.source,
  });

  factory LocalResponseDTO.fromJson(Map<String, dynamic> json) {
    return LocalResponseDTO(
      createdAt: json['createdAt'],
      content: Response.fromJson(json['content']),
      source: json['source'] != null ? LocalResponseSourceDTO.fromJson(json['source']) : null,
    );
  }

  static LocalResponseDTO? fromJsonNullable(Map<String, dynamic>? json) => json != null ? LocalResponseDTO.fromJson(json) : null;

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt,
        'content': content.toJson(),
        if (source != null) 'source': source?.toJson(),
      };

  @override
  String toString() => 'LocalResponseDTO(createdAt: $createdAt, content: $content, source: $source)';
}
