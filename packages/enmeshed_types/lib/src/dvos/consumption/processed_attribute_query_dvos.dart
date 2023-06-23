import 'package:json_annotation/json_annotation.dart';

import '../../contents/contents.dart';
import '../common/common.dart';
import '../data_view_object.dart';
import '../transport/transport.dart';
import 'local_attribute_dvo.dart';

part 'processed_attribute_query_dvos.g.dart';

sealed class ProcessedAttributeQueryDVO extends DataViewObject {
  final String? validFrom;
  final String? validTo;
  final bool isProcessed = true;

  ProcessedAttributeQueryDVO({
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

  factory ProcessedAttributeQueryDVO.fromJson(Map<String, dynamic> json) => switch (json['type']) {
        'ProcessedIdentityAttributeQueryDVO' => ProcessedIdentityAttributeQueryDVO.fromJson(json),
        'ProcessedRelationshipAttributeQueryDVO' => ProcessedRelationshipAttributeQueryDVO.fromJson(json),
        'ProcessedThirdPartyRelationshipAttributeQueryDVO' => ProcessedThirdPartyRelationshipAttributeQueryDVO.fromJson(json),
        _ => throw Exception("Invalid type '${json['type']}'"),
      };
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class ProcessedIdentityAttributeQueryDVO extends ProcessedAttributeQueryDVO {
  ProcessedIdentityAttributeQueryDVO({
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
  });

  factory ProcessedIdentityAttributeQueryDVO.fromJson(Map<String, dynamic> json) => _$ProcessedIdentityAttributeQueryDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProcessedIdentityAttributeQueryDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ProcessedRelationshipAttributeQueryDVO extends ProcessedAttributeQueryDVO {
  final List<RelationshipAttributeDVO> results;
  final String key;
  final IdentityDVO owner;
  final RelationshipAttributeCreationHints attributeCreationHints;
  final RenderHints renderHints;
  final ValueHints valueHints;

  ProcessedRelationshipAttributeQueryDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    super.validFrom,
    super.validTo,
    required this.results,
    required this.key,
    required this.owner,
    required this.attributeCreationHints,
    required this.renderHints,
    required this.valueHints,
  }) : super(type: 'ProcessedRelationshipAttributeQueryDVO');

  factory ProcessedRelationshipAttributeQueryDVO.fromJson(Map<String, dynamic> json) => _$ProcessedRelationshipAttributeQueryDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProcessedRelationshipAttributeQueryDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ProcessedThirdPartyRelationshipAttributeQueryDVO extends ProcessedAttributeQueryDVO {
  final List<RelationshipAttributeDVO> results;
  final String key;
  final IdentityDVO owner;
  final RelationshipAttributeCreationHints attributeCreationHints;
  final RenderHints renderHints;
  final ValueHints valueHints;

  ProcessedThirdPartyRelationshipAttributeQueryDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    super.validFrom,
    super.validTo,
    required this.results,
    required this.key,
    required this.owner,
    required this.attributeCreationHints,
    required this.renderHints,
    required this.valueHints,
  }) : super(type: 'ProcessedThirdPartyRelationshipAttributeQueryDVO');

  factory ProcessedThirdPartyRelationshipAttributeQueryDVO.fromJson(Map<String, dynamic> json) =>
      _$ProcessedThirdPartyRelationshipAttributeQueryDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProcessedThirdPartyRelationshipAttributeQueryDVOToJson(this);
}
