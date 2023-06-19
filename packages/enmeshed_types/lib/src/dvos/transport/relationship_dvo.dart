import 'package:enmeshed_types/src/dvos/dvos.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../dtos/relationship_change.dart';
import '../consumption/local_attribute_dvo.dart';

part 'relationship_dvo.g.dart';

enum RelationshipDirection { Incoming, Outgoing }

@JsonSerializable()
class RelationshipDVO extends DataViewObject {
  String status;
  RelationshipDirection direction;
  String statusText;
  bool isPinned;
  RelationshipTheme? theme;
  List<RelationshipChangeDVO> changes;
  int changeCount;
  List<LocalAttributeDVO> items;
  Map<String, List<LocalAttributeDVO>> attributeMap;
  Map<String, String> nameMap;
  String templateId;

  RelationshipDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.status,
    required this.direction,
    required this.statusText,
    required this.isPinned,
    this.theme,
    required this.changes,
    required this.changeCount,
    required this.items,
    required this.attributeMap,
    required this.nameMap,
    required this.templateId,
  });

  factory RelationshipDVO.fromJson(Map<String, dynamic> json) => _$RelationshipDVOFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipDVOToJson(this);
}

@JsonSerializable()
class RelationshipTheme {
  String? image;
  String? headerImage;
  String? backgroundColor;
  String? foregroundColor;

  RelationshipTheme({
    this.image,
    this.headerImage,
    this.backgroundColor,
    this.foregroundColor,
  });

  factory RelationshipTheme.fromJson(Map<String, dynamic> json) => _$RelationshipThemeFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipThemeToJson(this);
}

@JsonSerializable()
class RelationshipChangeDVO extends DataViewObject {
  RelationshipChangeRequestDVO request;
  RelationshipChangeResponseDVO? response;
  RelationshipChangeStatus status;
  String statusText;
  RelationshipChangeType changeType;
  String changeTypeText;
  bool isOwn;

  RelationshipChangeDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.request,
    this.response,
    required this.status,
    required this.statusText,
    required this.changeType,
    required this.changeTypeText,
    required this.isOwn,
  });

  factory RelationshipChangeDVO.fromJson(Map<String, dynamic> json) => _$RelationshipChangeDVOFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipChangeDVOToJson(this);
}

@JsonSerializable()
class RelationshipChangeRequestDVO extends DataViewObject {
  String createdBy;
  String createdByDevice;
  String createdAt;
  Map<String, dynamic>? content;

  RelationshipChangeRequestDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.createdBy,
    required this.createdByDevice,
    required this.createdAt,
    this.content,
  });

  factory RelationshipChangeRequestDVO.fromJson(Map<String, dynamic> json) => _$RelationshipChangeRequestDVOFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipChangeRequestDVOToJson(this);
}

@JsonSerializable()
class RelationshipChangeResponseDVO extends DataViewObject {
  String createdBy;
  String createdByDevice;
  String createdAt;
  Map<String, dynamic>? content;

  RelationshipChangeResponseDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.createdBy,
    required this.createdByDevice,
    required this.createdAt,
    this.content,
  });

  factory RelationshipChangeResponseDVO.fromJson(Map<String, dynamic> json) => _$RelationshipChangeResponseDVOFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipChangeResponseDVOToJson(this);
}
