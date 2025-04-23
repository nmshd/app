import 'package:json_annotation/json_annotation.dart';

import '../../contents/contents.dart';
import '../common/common.dart';
import '../consumption/consumption.dart';
import '../data_view_object.dart';
import '../transport/transport.dart';

part '../consumption/processed_attribute_query_dvos.dart';
part 'attribute_query_dvos.g.dart';

sealed class AttributeQueryDVO extends DataViewObject {
  final String? validFrom;
  final String? validTo;

  const AttributeQueryDVO({
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

  factory AttributeQueryDVO.fromJson(Map json) {
    final type = json['type'];

    if (type is String && type.startsWith('Processed')) {
      return ProcessedAttributeQueryDVO.fromJson(json);
    }

    return switch (json['type']) {
      'IdentityAttributeQueryDVO' => IdentityAttributeQueryDVO.fromJson(json),
      'RelationshipAttributeQueryDVO' => RelationshipAttributeQueryDVO.fromJson(json),
      'ThirdPartyRelationshipAttributeQueryDVO' => ThirdPartyRelationshipAttributeQueryDVO.fromJson(json),
      'IQLQueryDVO' => IQLQueryDVO.fromJson(json),
      _ => throw Exception("Invalid type '${json['type']}'"),
    };
  }
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class IdentityAttributeQueryDVO extends AttributeQueryDVO {
  final String valueType;
  final List<String>? tags;
  final bool isProcessed;
  final RenderHints renderHints;
  final ValueHints valueHints;

  const IdentityAttributeQueryDVO({
    required super.id,
    required super.name,
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

  factory IdentityAttributeQueryDVO.fromJson(Map json) => _$IdentityAttributeQueryDVOFromJson(Map<String, dynamic>.from(json));
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

  const RelationshipAttributeQueryDVO({
    required super.id,
    required super.name,
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

  factory RelationshipAttributeQueryDVO.fromJson(Map json) => _$RelationshipAttributeQueryDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$RelationshipAttributeQueryDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ThirdPartyRelationshipAttributeQueryDVO extends AttributeQueryDVO {
  final String key;
  final IdentityDVO owner;
  final List<IdentityDVO> thirdParty;
  final bool isProcessed;

  const ThirdPartyRelationshipAttributeQueryDVO({
    required super.id,
    required super.name,
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

  factory ThirdPartyRelationshipAttributeQueryDVO.fromJson(Map json) =>
      _$ThirdPartyRelationshipAttributeQueryDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ThirdPartyRelationshipAttributeQueryDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class IQLQueryDVO extends AttributeQueryDVO {
  final String queryString;
  final bool isProcessed;
  final String? valueType;
  final IQLQueryCreationHints? attributeCreationHints;
  final RenderHints? renderHints;
  final ValueHints? valueHints;
  final List<String>? tags;

  const IQLQueryDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    super.validFrom,
    super.validTo,
    required this.queryString,
    required this.isProcessed,
    this.valueType,
    this.attributeCreationHints,
    this.renderHints,
    this.valueHints,
    this.tags,
  });

  factory IQLQueryDVO.fromJson(Map json) => _$IQLQueryDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$IQLQueryDVOToJson(this);
}
