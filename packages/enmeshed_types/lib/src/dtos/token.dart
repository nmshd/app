import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../contents/contents.dart';
import 'object_reference.dart';

part 'token.g.dart';

@JsonSerializable(includeIfNull: false)
class TokenDTO extends Equatable {
  final String id;
  final String createdBy;
  final String createdByDevice;
  final TokenContent content;
  final String createdAt;
  final String expiresAt;
  final String? forIdentity;
  final bool isEphemeral;
  final PasswordProtection? passwordProtection;
  final ObjectReferenceDTO reference;

  const TokenDTO({
    required this.id,
    required this.createdBy,
    required this.createdByDevice,
    required this.content,
    required this.createdAt,
    required this.expiresAt,
    required this.isEphemeral,
    this.forIdentity,
    this.passwordProtection,
    required this.reference,
  });

  factory TokenDTO.fromJson(Map json) => _$TokenDTOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$TokenDTOToJson(this);

  @override
  List<Object?> get props => [id, createdBy, createdByDevice, content, createdAt, expiresAt, forIdentity, isEphemeral, passwordProtection, reference];
}
