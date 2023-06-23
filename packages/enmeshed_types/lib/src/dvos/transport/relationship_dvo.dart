import 'package:json_annotation/json_annotation.dart';

import '../../dtos/relationship_change.dart';
import '../common/common.dart';
import '../consumption/local_attribute_dvo.dart';
import '../data_view_object.dart';

part 'relationship_dvo.g.dart';

enum RelationshipDirection { Incoming, Outgoing }

@JsonSerializable(includeIfNull: false)
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

  factory RelationshipDVO.fromJson(Map json) => _$RelationshipDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$RelationshipDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
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

  factory RelationshipTheme.fromJson(Map json) => _$RelationshipThemeFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$RelationshipThemeToJson(this);
}

@JsonSerializable(includeIfNull: false)
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

  factory RelationshipChangeDVO.fromJson(Map json) => _$RelationshipChangeDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$RelationshipChangeDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
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

  factory RelationshipChangeRequestDVO.fromJson(Map json) => _$RelationshipChangeRequestDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$RelationshipChangeRequestDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
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

  factory RelationshipChangeResponseDVO.fromJson(Map json) => _$RelationshipChangeResponseDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$RelationshipChangeResponseDVOToJson(this);
}
