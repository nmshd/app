import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../dtos/relationship_change.dart';
import '../common/common.dart';
import '../consumption/local_attribute_dvo.dart';
import '../data_view_object.dart';
import '../integer_converter.dart';

part 'relationship_dvo.g.dart';

enum RelationshipDirection { Incoming, Outgoing }

@JsonSerializable(includeIfNull: false)
class RelationshipDVO extends DataViewObject with EquatableMixin {
  final String status;
  final RelationshipDirection direction;
  final String statusText;
  final bool isPinned;
  final RelationshipTheme? theme;
  final List<RelationshipChangeDVO> changes;
  @IntegerConverter()
  final int changeCount;
  final List<LocalAttributeDVO> items;
  final Map<String, List<LocalAttributeDVO>> attributeMap;
  final Map<String, String> nameMap;
  final String templateId;

  const RelationshipDVO({
    required super.id,
    required super.name,
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

  @override
  // relationship is equal if id is equal other fields are too volatile
  List<Object?> get props => [id];
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
  final RelationshipChangeRequestDVO request;
  final RelationshipChangeResponseDVO? response;
  final RelationshipChangeStatus status;
  final String statusText;
  final RelationshipChangeType changeType;
  final String changeTypeText;
  final bool isOwn;

  const RelationshipChangeDVO({
    required super.id,
    required super.name,
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
  final String createdBy;
  final String createdByDevice;
  final String createdAt;
  final Map<String, dynamic>? content;

  const RelationshipChangeRequestDVO({
    required super.id,
    required super.name,
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
  final String createdBy;
  final String createdByDevice;
  final String createdAt;
  final Map<String, dynamic>? content;

  const RelationshipChangeResponseDVO({
    required super.id,
    required super.name,
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
