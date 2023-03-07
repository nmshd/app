import '../contents/contents.dart';

class TokenDTO {
  final String id;
  final String createdBy;
  final String createdByDevice;
  final TokenContent content;
  final String createdAt;
  final String expiresAt;
  final String secretKey;
  final String truncatedReference;
  final bool isEphemeral;

  TokenDTO({
    required this.id,
    required this.createdBy,
    required this.createdByDevice,
    required this.content,
    required this.createdAt,
    required this.expiresAt,
    required this.secretKey,
    required this.truncatedReference,
    required this.isEphemeral,
  });

  @override
  String toString() {
    return 'TokenDTO(id: $id, createdBy: $createdBy, createdByDevice: $createdByDevice, content: $content, createdAt: $createdAt, expiresAt: $expiresAt, secretKey: $secretKey, truncatedReference: $truncatedReference, isEphemeral: $isEphemeral)';
  }

  factory TokenDTO.fromJson(Map<String, dynamic> json) {
    return TokenDTO(
      id: json['id'],
      createdBy: json['createdBy'],
      createdByDevice: json['createdByDevice'],
      content: json['content'],
      createdAt: json['createdAt'],
      expiresAt: json['expiresAt'],
      secretKey: json['secretKey'],
      truncatedReference: json['truncatedReference'],
      isEphemeral: json['isEphemeral'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdBy': createdBy,
      'createdByDevice': createdByDevice,
      'content': content,
      'createdAt': createdAt,
      'expiresAt': expiresAt,
      'secretKey': secretKey,
      'truncatedReference': truncatedReference,
      'isEphemeral': isEphemeral,
    };
  }
}
