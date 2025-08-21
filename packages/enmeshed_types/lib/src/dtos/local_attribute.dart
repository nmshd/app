import 'package:equatable/equatable.dart';

import '../contents/contents.dart';
import 'local_attribute_deletion_info.dart';
import 'local_attribute_share_info.dart';

class LocalAttributeDTO<T extends AbstractAttribute> extends Equatable {
  final String id;
  final String? parentId;
  final String createdAt;
  final T content;
  final String? succeeds;
  final String? succeededBy;
  final LocalAttributeShareInfo? shareInfo;
  final LocalAttributeDeletionInfo? deletionInfo;
  final bool? isDefault;
  final String? wasViewedAt;

  const LocalAttributeDTO({
    required this.id,
    this.parentId,
    required this.createdAt,
    required this.content,
    this.succeeds,
    this.succeededBy,
    this.shareInfo,
    this.deletionInfo,
    this.isDefault,
    this.wasViewedAt,
  });

  RelationshipAttribute get contentAsRelationshipAttribute {
    if (content is! RelationshipAttribute) throw Exception('Content is not a RelationshipAttribute');
    return content as RelationshipAttribute;
  }

  IdentityAttribute get contentAsIdentityAttribute {
    if (content is! IdentityAttribute) throw Exception('Content is not an IdentityAttribute');
    return content as IdentityAttribute;
  }

  factory LocalAttributeDTO.fromJson(Map json) {
    return LocalAttributeDTO(
      id: json['id'],
      parentId: json['parentId'],
      createdAt: json['createdAt'],
      content: AbstractAttribute.fromJson(json['content']) as T,
      succeeds: json['succeeds'],
      succeededBy: json['succeededBy'],
      shareInfo: LocalAttributeShareInfo.fromJsonNullable(json['shareInfo']),
      deletionInfo: LocalAttributeDeletionInfo.fromJsonNullable(json['deletionInfo']),
      isDefault: json['isDefault'],
      wasViewedAt: json['wasViewedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    if (parentId != null) 'parentId': parentId,
    'createdAt': createdAt,
    'content': content.toJson(),
    if (succeeds != null) 'succeeds': succeeds,
    if (succeededBy != null) 'succeededBy': succeededBy,
    if (shareInfo != null) 'shareInfo': shareInfo?.toJson(),
    if (deletionInfo != null) 'deletionInfo': deletionInfo?.toJson(),
    if (isDefault != null) 'isDefault': isDefault,
    if (wasViewedAt != null) 'wasViewedAt': wasViewedAt,
  };

  @override
  List<Object?> get props => [id, parentId, createdAt, content, succeeds, succeededBy, shareInfo, deletionInfo, isDefault, wasViewedAt];
}
