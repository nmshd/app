import 'package:equatable/equatable.dart';

import '../contents/contents.dart';
import 'local_attribute_share_info.dart';

class LocalAttributeDTO extends Equatable {
  final String id;
  final String? parentId;
  final String createdAt;
  final AbstractAttribute content;
  final String? succeeds;
  final String? succeededBy;
  final LocalAttributeShareInfo? shareInfo;

  const LocalAttributeDTO({
    required this.id,
    this.parentId,
    required this.createdAt,
    required this.content,
    this.succeeds,
    this.succeededBy,
    this.shareInfo,
  });

  RelationshipAttribute get contentAsRelationshipAttribute {
    if (content is! RelationshipAttribute) throw Exception('Content is not a RelationshipAttribute');
    return content as RelationshipAttribute;
  }

  IdentityAttribute get contentAsIdentityAttribute {
    if (content is! IdentityAttribute) throw Exception('Content is not an IdentityAttribute');
    return content as IdentityAttribute;
  }

  factory LocalAttributeDTO.fromJson(Map<String, dynamic> json) {
    return LocalAttributeDTO(
      id: json['id'],
      parentId: json['parentId'],
      createdAt: json['createdAt'],
      content: AbstractAttribute.fromJson(json['content']),
      succeeds: json['succeeds'],
      succeededBy: json['succeededBy'],
      shareInfo: LocalAttributeShareInfo.fromJsonNullable(json['shareInfo']),
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
      };

  @override
  String toString() {
    return 'LocalAttributeDTO(id: $id, parentId: $parentId, createdAt: $createdAt, content: $content, succeeds: $succeeds, succeededBy: $succeededBy, shareInfo: $shareInfo)';
  }

  @override
  List<Object?> get props => [id, parentId, createdAt, content, succeeds, succeededBy, shareInfo];
}
