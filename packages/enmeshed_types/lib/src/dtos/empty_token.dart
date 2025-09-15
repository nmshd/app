import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import 'object_reference.dart';

part 'empty_token.g.dart';

@JsonSerializable(includeIfNull: false)
class EmptyTokenDTO extends Equatable {
  final String id;
  final String expiresAt;
  final PasswordProtection passwordProtection;
  final ObjectReferenceDTO reference;

  const EmptyTokenDTO({required this.id, required this.expiresAt, required this.passwordProtection, required this.reference});

  factory EmptyTokenDTO.fromJson(Map json) => _$EmptyTokenDTOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$EmptyTokenDTOToJson(this);

  @override
  List<Object?> get props => [id, expiresAt, passwordProtection, reference];
}
