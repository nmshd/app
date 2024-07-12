import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../contents/contents.dart';
import '../../dtos/dtos.dart';
import '../consumption/local_attribute_dvo.dart';
import '../data_view_object.dart';

part 'relationship_dvo.g.dart';

enum RelationshipDirection { Incoming, Outgoing }

@JsonSerializable(includeIfNull: false)
class RelationshipDVO extends DataViewObject with EquatableMixin {
  final String status;
  final RelationshipDirection direction;
  final String statusText;
  final bool isPinned;
  final RelationshipTheme? theme;
  final RelationshipCreationContentDerivation creationContent;
  final List<RelationshipAuditLogEntryDTO> auditLog;
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
    required this.creationContent,
    required this.auditLog,
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
