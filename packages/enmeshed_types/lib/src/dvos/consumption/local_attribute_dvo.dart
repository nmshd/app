import 'package:json_annotation/json_annotation.dart';

import '../../contents/contents.dart';
import '../common/common.dart';
import '../data_view_object.dart';

part 'local_attribute_dvo.g.dart';

sealed class LocalAttributeDVO extends DataViewObject {
  final AbstractAttribute content;
  final String owner;

  final AttributeValue value;
  final String valueType;

  final RenderHints renderHints;
  final ValueHints valueHints;

  final bool isDraft;
  final bool isOwn;
  final bool isValid;

  final String createdAt;
  final String? succeeds;
  final String? succeededBy;

  const LocalAttributeDVO({
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
    required this.value,
    required this.valueType,
    required this.renderHints,
    required this.valueHints,
    required this.isDraft,
    required this.isOwn,
    required this.isValid,
    required this.createdAt,
    this.succeeds,
    this.succeededBy,
  });

  factory LocalAttributeDVO.fromJson(Map json) => switch (json['type']) {
        'RepositoryAttributeDVO' => RepositoryAttributeDVO.fromJson(json),
        'SharedToPeerAttributeDVO' => SharedToPeerAttributeDVO.fromJson(json),
        'PeerAttributeDVO' => PeerAttributeDVO.fromJson(json),
        'OwnRelationshipAttributeDVO' => OwnRelationshipAttributeDVO.fromJson(json),
        'PeerRelationshipAttributeDVO' => PeerRelationshipAttributeDVO.fromJson(json),
        _ => throw Exception("Invalid type '${json['type']}'"),
      };
  Map<String, dynamic> toJson();
}

sealed class IdentityAttributeDVO extends LocalAttributeDVO {
  const IdentityAttributeDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required super.content,
    required super.owner,
    required super.value,
    required super.valueType,
    required super.renderHints,
    required super.valueHints,
    required super.isDraft,
    required super.isValid,
    required super.createdAt,
    super.succeeds,
    super.succeededBy,
  }) : super(isOwn: true);

  factory IdentityAttributeDVO.fromJson(Map json) => switch (json['type']) {
        'RepositoryAttributeDVO' => RepositoryAttributeDVO.fromJson(json),
        'SharedToPeerAttributeDVO' => SharedToPeerAttributeDVO.fromJson(json),
        _ => throw Exception("Invalid type '${json['type']}'"),
      };
  @override
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class RepositoryAttributeDVO extends IdentityAttributeDVO {
  final List<SharedToPeerAttributeDVO> sharedWith;
  final List<String>? tags;
  final bool? isDefault;

  const RepositoryAttributeDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.content,
    required super.owner,
    this.tags,
    required super.value,
    required super.valueType,
    required super.renderHints,
    required super.valueHints,
    required super.isDraft,
    required super.isValid,
    required super.createdAt,
    super.succeeds,
    super.succeededBy,
    required this.sharedWith,
    this.isDefault,
  }) : super(type: 'RepositoryAttributeDVO');

  factory RepositoryAttributeDVO.fromJson(Map json) => _$RepositoryAttributeDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$RepositoryAttributeDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SharedToPeerAttributeDVO extends IdentityAttributeDVO {
  final String peer;
  final String? requestReference;
  final String? notificationReference;
  final String? sourceAttribute;
  final List<String>? tags;
  final String? deletionDate;
  final String? deletionStatus;

  const SharedToPeerAttributeDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.content,
    required super.owner,
    this.tags,
    required super.value,
    required super.valueType,
    required super.renderHints,
    required super.valueHints,
    required super.isDraft,
    required super.isValid,
    required super.createdAt,
    super.succeeds,
    super.succeededBy,
    required this.peer,
    this.requestReference,
    this.notificationReference,
    this.sourceAttribute,
    this.deletionDate,
    this.deletionStatus,
  }) : super(type: 'SharedToPeerAttributeDVO');

  factory SharedToPeerAttributeDVO.fromJson(Map json) => _$SharedToPeerAttributeDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$SharedToPeerAttributeDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class PeerAttributeDVO extends LocalAttributeDVO {
  final String peer;
  final String? requestReference;
  final String? notificationReference;
  final List<String>? tags;
  final String? deletionDate;
  final String? deletionStatus;

  const PeerAttributeDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.content,
    required super.owner,
    required super.value,
    required super.valueType,
    required super.renderHints,
    required super.valueHints,
    required super.isDraft,
    required super.isValid,
    required super.createdAt,
    super.succeeds,
    super.succeededBy,
    required this.peer,
    this.requestReference,
    this.notificationReference,
    this.tags,
    this.deletionDate,
    this.deletionStatus,
  }) : super(type: 'PeerAttributeDVO', isOwn: false);

  factory PeerAttributeDVO.fromJson(Map json) => _$PeerAttributeDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$PeerAttributeDVOToJson(this);
}

sealed class RelationshipAttributeDVO extends LocalAttributeDVO {
  final String key;
  final String peer;
  final String? requestReference;
  final String? notificationReference;
  final String? sourceAttribute;
  final String? thirdPartyAddress;
  final String confidentiality;
  final bool isTechnical;
  final String? deletionDate;
  final String? deletionStatus;

  const RelationshipAttributeDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required super.content,
    required super.owner,
    required super.value,
    required super.valueType,
    required super.renderHints,
    required super.valueHints,
    required super.isDraft,
    required super.isOwn,
    required super.isValid,
    required super.createdAt,
    super.succeeds,
    super.succeededBy,
    required this.key,
    required this.peer,
    this.requestReference,
    this.notificationReference,
    this.sourceAttribute,
    this.thirdPartyAddress,
    required this.confidentiality,
    required this.isTechnical,
    this.deletionDate,
    this.deletionStatus,
  });

  factory RelationshipAttributeDVO.fromJson(Map json) => switch (json['type']) {
        'OwnRelationshipAttributeDVO' => OwnRelationshipAttributeDVO.fromJson(json),
        'PeerRelationshipAttributeDVO' => PeerRelationshipAttributeDVO.fromJson(json),
        _ => throw Exception("Invalid type '${json['type']}'"),
      };
  @override
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class OwnRelationshipAttributeDVO extends RelationshipAttributeDVO {
  const OwnRelationshipAttributeDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.content,
    required super.owner,
    required super.value,
    required super.valueType,
    required super.renderHints,
    required super.valueHints,
    required super.isDraft,
    required super.isValid,
    required super.createdAt,
    super.succeeds,
    super.succeededBy,
    required super.key,
    required super.peer,
    super.requestReference,
    super.notificationReference,
    super.sourceAttribute,
    super.thirdPartyAddress,
    required super.confidentiality,
    required super.isTechnical,
    super.deletionDate,
    super.deletionStatus,
  }) : super(type: 'OwnRelationshipAttributeDVO', isOwn: true);

  factory OwnRelationshipAttributeDVO.fromJson(Map json) => _$OwnRelationshipAttributeDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$OwnRelationshipAttributeDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class PeerRelationshipAttributeDVO extends RelationshipAttributeDVO {
  const PeerRelationshipAttributeDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.content,
    required super.owner,
    required super.value,
    required super.valueType,
    required super.renderHints,
    required super.valueHints,
    required super.isDraft,
    required super.isValid,
    required super.createdAt,
    super.succeeds,
    super.succeededBy,
    required super.key,
    required super.peer,
    super.requestReference,
    super.notificationReference,
    super.sourceAttribute,
    super.thirdPartyAddress,
    required super.confidentiality,
    required super.isTechnical,
    super.deletionDate,
    super.deletionStatus,
  }) : super(type: 'PeerRelationshipAttributeDVO', isOwn: false);

  factory PeerRelationshipAttributeDVO.fromJson(Map json) => _$PeerRelationshipAttributeDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$PeerRelationshipAttributeDVOToJson(this);
}
