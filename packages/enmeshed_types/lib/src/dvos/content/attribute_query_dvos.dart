import 'package:json_annotation/json_annotation.dart';

import '../../contents/contents.dart';
import '../common/common.dart';
import '../data_view_object.dart';
import '../transport/transport.dart';

part 'attribute_query_dvos.g.dart';

sealed class AttributeQueryDVO extends DataViewObject {
  final String? validFrom;
  final String? validTo;

  AttributeQueryDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    this.validFrom,
    this.validTo,
  });

  factory AttributeQueryDVO.fromJson(Map<String, dynamic> json) => switch (json['type']) {
        'IdentityAttributeQueryDVO' => IdentityAttributeQueryDVO.fromJson(json),
        'RelationshipAttributeQueryDVO' => RelationshipAttributeQueryDVO.fromJson(json),
        'ThirdPartyRelationshipAttributeQueryDVO' => ThirdPartyRelationshipAttributeQueryDVO.fromJson(json),
        _ => throw Exception("Invalid type '${json['type']}'"),
      };
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class IdentityAttributeQueryDVO extends AttributeQueryDVO {
  final String valueType;
  final List<String>? tags;
  final bool isProcessed;
  final RenderHints renderHints;
  final ValueHints valueHints;

  IdentityAttributeQueryDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    super.validFrom,
    super.validTo,
    required this.valueType,
    this.tags,
    required this.isProcessed,
    required this.renderHints,
    required this.valueHints,
  });

  factory IdentityAttributeQueryDVO.fromJson(Map<String, dynamic> json) => _$IdentityAttributeQueryDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$IdentityAttributeQueryDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RelationshipAttributeQueryDVO extends AttributeQueryDVO {
  final String valueType;
  final String key;
  final IdentityDVO owner;
  final RelationshipAttributeCreationHints attributeCreationHints;
  final bool isProcessed;
  final RenderHints renderHints;
  final ValueHints valueHints;

  RelationshipAttributeQueryDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    super.validFrom,
    super.validTo,
    required this.valueType,
    required this.key,
    required this.owner,
    required this.attributeCreationHints,
    required this.isProcessed,
    required this.renderHints,
    required this.valueHints,
  });

  factory RelationshipAttributeQueryDVO.fromJson(Map<String, dynamic> json) => _$RelationshipAttributeQueryDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RelationshipAttributeQueryDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ThirdPartyRelationshipAttributeQueryDVO extends AttributeQueryDVO {
  final String key;
  final IdentityDVO owner;
  final List<IdentityDVO> thirdParty;
  final bool isProcessed;

  ThirdPartyRelationshipAttributeQueryDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    super.validFrom,
    super.validTo,
    required this.key,
    required this.owner,
    required this.thirdParty,
    required this.isProcessed,
  });

  factory ThirdPartyRelationshipAttributeQueryDVO.fromJson(Map<String, dynamic> json) => _$ThirdPartyRelationshipAttributeQueryDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ThirdPartyRelationshipAttributeQueryDVOToJson(this);
}
