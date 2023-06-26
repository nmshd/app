import 'package:json_annotation/json_annotation.dart';

import '../../contents/contents.dart';
import '../common/common.dart';
import '../data_view_object.dart';
import '../transport/transport.dart';

part 'attribute_dvos.g.dart';

sealed class DraftAttributeDVO extends DataViewObject {
  DraftAttributeDVO({
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
  dynamic content;
  IdentityDVO owner;
  RenderHints renderHints;
  ValueHints valueHints;
  String valueType;
  bool isOwn;
  bool isDraft;
  String? succeeds;
  String? succeededBy;
  dynamic value;
  List<String> tags;

  DraftIdentityAttributeDVO({
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
  dynamic content;
  IdentityDVO owner;
  RenderHints renderHints;
  ValueHints valueHints;
  String valueType;
  bool isOwn;
  bool isDraft;
  String? succeeds;
  String? succeededBy;
  dynamic value;
  String key;
  bool isTechnical;
  String confidentiality;

  DraftRelationshipAttributeDVO({
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
