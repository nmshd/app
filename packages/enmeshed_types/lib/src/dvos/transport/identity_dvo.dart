import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../data_view_object.dart';
import 'relationship_dvo.dart';

part 'identity_dvo.g.dart';

@JsonSerializable(includeIfNull: false)
class IdentityDVO extends DataViewObject {
  String? publicKey;
  String realm;
  String initials;
  bool isSelf;
  bool hasRelationship;
  RelationshipDVO? relationship;

  IdentityDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    this.publicKey,
    required this.realm,
    required this.initials,
    required this.isSelf,
    required this.hasRelationship,
    this.relationship,
  });

  factory IdentityDVO.fromJson(Map json) => _$IdentityDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$IdentityDVOToJson(this);
}
