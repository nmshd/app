import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../data_view_object.dart';
import 'relationship_dvo.dart';

part 'identity_dvo.g.dart';

@JsonSerializable(includeIfNull: false)
class IdentityDVO extends DataViewObject with EquatableMixin {
  final String? publicKey;
  final String initials;
  final bool isSelf;
  final bool hasRelationship;
  final RelationshipDVO? relationship;
  final String? originalName;

  const IdentityDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    this.publicKey,
    required this.initials,
    required this.isSelf,
    required this.hasRelationship,
    this.relationship,
    this.originalName,
  });

  factory IdentityDVO.fromJson(Map json) => _$IdentityDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$IdentityDVOToJson(this);

  @override
  List<Object?> get props => [id, name, description, image, type, date, error, warning, publicKey, initials, isSelf, hasRelationship, relationship];
}
