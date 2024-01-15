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

  const ProcessedAttributeQueryDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    this.validFrom,
    this.validTo,
  });

  factory ProcessedAttributeQueryDVO.fromJson(Map json) => switch (json['type']) {
        'ProcessedIdentityAttributeQueryDVO' => ProcessedIdentityAttributeQueryDVO.fromJson(json),
        'ProcessedRelationshipAttributeQueryDVO' => ProcessedRelationshipAttributeQueryDVO.fromJson(json),
        'ProcessedThirdPartyRelationshipAttributeQueryDVO' => ProcessedThirdPartyRelationshipAttributeQueryDVO.fromJson(json),
        'ProcessedIQLQueryDVO' => ProcessedIQLQueryDVO.fromJson(json),
        _ => throw Exception("Invalid type '${json['type']}'"),
      };
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class ProcessedIdentityAttributeQueryDVO extends ProcessedAttributeQueryDVO {
  final List<IdentityAttributeDVO> results;
  final List<String>? tags;
  final String valueType;
  final RenderHints renderHints;
  final ValueHints valueHints;

  const ProcessedIdentityAttributeQueryDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    super.validFrom,
    super.validTo,
    required this.results,
    required this.tags,
    required this.valueType,
    required this.renderHints,
    required this.valueHints,
  }) : super(type: 'ProcessedIdentityAttributeQueryDVO');

  factory ProcessedIdentityAttributeQueryDVO.fromJson(Map json) => _$ProcessedIdentityAttributeQueryDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ProcessedIdentityAttributeQueryDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ProcessedRelationshipAttributeQueryDVO extends ProcessedAttributeQueryDVO {
  final List<RelationshipAttributeDVO> results;
  final String key;
  final IdentityDVO owner;
  final RelationshipAttributeCreationHints attributeCreationHints;
  final String valueType;
  final RenderHints renderHints;
  final ValueHints valueHints;

  const ProcessedRelationshipAttributeQueryDVO({
    required super.id,
    required super.name,
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
    required this.valueType,
    required this.renderHints,
    required this.valueHints,
  }) : super(type: 'ProcessedRelationshipAttributeQueryDVO');

  factory ProcessedRelationshipAttributeQueryDVO.fromJson(Map json) =>
      _$ProcessedRelationshipAttributeQueryDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ProcessedRelationshipAttributeQueryDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ProcessedThirdPartyRelationshipAttributeQueryDVO extends ProcessedAttributeQueryDVO {
  final List<RelationshipAttributeDVO> results;
  final String key;
  final IdentityDVO owner;
  final List<IdentityDVO> thirdParty;
  final String? valueType;
  final RenderHints? renderHints;
  final ValueHints? valueHints;

  const ProcessedThirdPartyRelationshipAttributeQueryDVO({
    required super.id,
    required super.name,
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
    required this.thirdParty,
    this.valueType,
    this.renderHints,
    this.valueHints,
  }) : super(type: 'ProcessedThirdPartyRelationshipAttributeQueryDVO');

  factory ProcessedThirdPartyRelationshipAttributeQueryDVO.fromJson(Map json) =>
      _$ProcessedThirdPartyRelationshipAttributeQueryDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ProcessedThirdPartyRelationshipAttributeQueryDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ProcessedIQLQueryDVO extends ProcessedAttributeQueryDVO {
  final List<RepositoryAttributeDVO> results;
  final String? valueType;
  final RenderHints? renderHints;
  final ValueHints? valueHints;
  final List<String>? tags;

  const ProcessedIQLQueryDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    super.validFrom,
    super.validTo,
    required this.results,
    this.valueType,
    this.renderHints,
    this.valueHints,
    this.tags,
  }) : super(type: 'ProcessedIQLQueryDVO');

  factory ProcessedIQLQueryDVO.fromJson(Map json) => _$ProcessedIQLQueryDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ProcessedIQLQueryDVOToJson(this);
}
