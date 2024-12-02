import 'package:equatable/equatable.dart';

import '../common/common.dart';
import '../contents/contents.dart';

class TokenDTO extends Equatable {
  final String id;
  final String createdBy;
  final String createdByDevice;
  final TokenContent content;
  final String createdAt;
  final String expiresAt;
  final String? forIdentity;
  final String truncatedReference;
  final bool isEphemeral;
  final PasswordProtection? passwordProtection;

  const TokenDTO({
    required this.id,
    required this.createdBy,
    required this.createdByDevice,
    required this.content,
    required this.createdAt,
    required this.expiresAt,
    required this.truncatedReference,
    required this.isEphemeral,
    this.forIdentity,
    this.passwordProtection,
  });

  factory TokenDTO.fromJson(Map json) {
    return TokenDTO(
      id: json['id'],
      createdBy: json['createdBy'],
      createdByDevice: json['createdByDevice'],
      content: TokenContent.fromJson(json['content']),
      createdAt: json['createdAt'],
      expiresAt: json['expiresAt'],
      forIdentity: json['forIdentity'],
      truncatedReference: json['truncatedReference'],
      isEphemeral: json['isEphemeral'],
      passwordProtection: json['passwordProtection'] != null ? PasswordProtection.fromJson(json['passwordProtection']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdBy': createdBy,
      'createdByDevice': createdByDevice,
      'content': content.toJson(),
      'createdAt': createdAt,
      'expiresAt': expiresAt,
      if (forIdentity != null) 'forIdentity': forIdentity,
      'truncatedReference': truncatedReference,
      'isEphemeral': isEphemeral,
      if (passwordProtection != null) 'passwordProtection': passwordProtection!.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        createdBy,
        createdByDevice,
        content,
        createdAt,
        expiresAt,
        forIdentity,
        truncatedReference,
        isEphemeral,
        passwordProtection,
      ];
}
