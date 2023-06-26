import 'package:json_annotation/json_annotation.dart';

import '../../dtos/local_request.dart';
import '../common/common.dart';
import '../content/content.dart';
import '../data_view_object.dart';
import '../transport/transport.dart';

part 'local_request_dvo.g.dart';

@JsonSerializable(includeIfNull: false)
class LocalRequestDVO extends DataViewObject {
  final bool isOwn;
  final String createdAt;
  final RequestDVO content;
  final LocalRequestStatus status;
  final String statusText;
  final String directionText;
  final String sourceTypeText;
  final IdentityDVO createdBy;
  final IdentityDVO peer;
  final LocalResponseDVO? response;
  final LocalRequestSourceDVO? source;
  final IdentityDVO decider;
  final bool isDecidable;
  final List<RequestItemDVO> items;

  const LocalRequestDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.isOwn,
    required this.createdAt,
    required this.content,
    required this.status,
    required this.statusText,
    required this.directionText,
    required this.sourceTypeText,
    required this.createdBy,
    required this.peer,
    this.response,
    this.source,
    required this.decider,
    required this.isDecidable,
    required this.items,
  });

  factory LocalRequestDVO.fromJson(Map json) => _$LocalRequestDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$LocalRequestDVOToJson(this);
}

enum LocalRequestSourceDVOType { Message, RelationshipChange }

@JsonSerializable(includeIfNull: false)
class LocalRequestSourceDVO {
  final LocalRequestSourceDVOType type;
  final String reference;

  const LocalRequestSourceDVO({
    required this.type,
    required this.reference,
  });

  factory LocalRequestSourceDVO.fromJson(Map json) => _$LocalRequestSourceDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$LocalRequestSourceDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class LocalResponseDVO extends DataViewObject {
  final String createdAt;
  final ResponseDVO content;
  final LocalResponseSourceDVO? source;

  const LocalResponseDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.createdAt,
    required this.content,
    this.source,
  });

  factory LocalResponseDVO.fromJson(Map json) => _$LocalResponseDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$LocalResponseDVOToJson(this);
}

enum LocalResponseSourceDVOType { Message, RelationshipChange }

@JsonSerializable(includeIfNull: false)
class LocalResponseSourceDVO {
  final LocalResponseSourceDVOType type;
  final String reference;

  const LocalResponseSourceDVO({
    required this.type,
    required this.reference,
  });

  factory LocalResponseSourceDVO.fromJson(Map json) => _$LocalResponseSourceDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$LocalResponseSourceDVOToJson(this);
}
