import 'package:json_annotation/json_annotation.dart';

import '../../contents/contents.dart';
import '../common/common.dart';
import '../data_view_object.dart';
import '../transport/transport.dart';

part 'attribute_dvos.g.dart';

sealed class DraftAttributeDVO extends DataViewObject {
  const DraftAttributeDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
  });

  factory DraftAttributeDVO.fromJson(Map json) => switch (json['type']) {
        'DraftIdentityAttributeDVO' => DraftIdentityAttributeDVO.fromJson(json),
        'DraftRelationshipAttributeDVO' => DraftRelationshipAttributeDVO.fromJson(json),
        _ => throw Exception("Invalid type '${json['type']}'"),
      };
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class DraftIdentityAttributeDVO extends DraftAttributeDVO {
  final AbstractAttribute content;
  final IdentityDVO owner;
  final RenderHints renderHints;
  final ValueHints valueHints;
  final String valueType;
  final bool isOwn;
  final bool isDraft;
  final String? succeeds;
  final String? succeededBy;
  final AttributeValue value;
  final List<String> tags;

  const DraftIdentityAttributeDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.content,
    required this.owner,
    required this.renderHints,
    required this.valueHints,
    required this.valueType,
    required this.isOwn,
    required this.isDraft,
    this.succeeds,
    this.succeededBy,
    required this.value,
    required this.tags,
  });

  factory DraftIdentityAttributeDVO.fromJson(Map json) => _$DraftIdentityAttributeDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DraftIdentityAttributeDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DraftRelationshipAttributeDVO extends DraftAttributeDVO {
  final AbstractAttribute content;
  final IdentityDVO owner;
  final RenderHints renderHints;
  final ValueHints valueHints;
  final String valueType;
  final bool isOwn;
  final bool isDraft;
  final String? succeeds;
  final String? succeededBy;
  final AttributeValue value;
  final String key;
  final bool isTechnical;
  final String confidentiality;

  const DraftRelationshipAttributeDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.content,
    required this.owner,
    required this.renderHints,
    required this.valueHints,
    required this.valueType,
    required this.isOwn,
    required this.isDraft,
    this.succeeds,
    this.succeededBy,
    required this.value,
    required this.key,
    required this.isTechnical,
    required this.confidentiality,
  });

  factory DraftRelationshipAttributeDVO.fromJson(Map json) => _$DraftRelationshipAttributeDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DraftRelationshipAttributeDVOToJson(this);
}
