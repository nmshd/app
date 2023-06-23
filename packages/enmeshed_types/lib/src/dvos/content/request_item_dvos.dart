import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../consumption/consumption.dart';
import '../data_view_object.dart';
import 'attribute_dvos.dart';
import 'attribute_query_dvos.dart';
import 'response_item_dvos.dart';

part '../consumption/decidable_request_item_dvos.dart';
part 'request_item_dvos.g.dart';

sealed class RequestItemDVO extends DataViewObject {
  final bool mustBeAccepted;
  final bool isDecidable;

  RequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.mustBeAccepted,
    required this.isDecidable,
  });

  factory RequestItemDVO.fromJson(Map json) => switch (json['type']) {
        'RequestItemGroupDVO' => RequestItemGroupDVO.fromJson(json),
        _ => RequestItemDVODerivation.fromJson(json),
      };
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class RequestItemGroupDVO extends RequestItemDVO {
  final List<RequestItemDVODerivation> items;
  final String? title;
  final ResponseItemGroupDVO? response;

  RequestItemGroupDVO({
    required super.isDecidable,
    required super.mustBeAccepted,
    required this.items,
    this.title,
    this.response,
  }) : super(id: 'n/a', name: 'n/a', type: 'RequestItemGroupDVO');

  factory RequestItemGroupDVO.fromJson(Map json) => _$RequestItemGroupDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$RequestItemGroupDVOToJson(this);
}

sealed class RequestItemDVODerivation extends RequestItemDVO {
  RequestItemDVODerivation({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
  });

  factory RequestItemDVODerivation.fromJson(Map json) => switch (json['type']) {
        'ReadAttributeRequestItemDVO' => ReadAttributeRequestItemDVO.fromJson(json),
        'ProposeAttributeRequestItemDVO' => ProposeAttributeRequestItemDVO.fromJson(json),
        'CreateAttributeRequestItemDVO' => CreateAttributeRequestItemDVO.fromJson(json),
        'ShareAttributeRequestItemDVO' => ShareAttributeRequestItemDVO.fromJson(json),
        'AuthenticationRequestItemDVO' => AuthenticationRequestItemDVO.fromJson(json),
        'ConsentRequestItemDVO' => ConsentRequestItemDVO.fromJson(json),
        'RegisterAttributeListenerRequestItemDVO' => RegisterAttributeListenerRequestItemDVO.fromJson(json),
        _ => throw Exception("Invalid type '${json['type']}'"),
      };

  @override
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class ReadAttributeRequestItemDVO extends RequestItemDVODerivation {
  final AttributeQueryDVO query;

  ReadAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    required this.query,
  }) : super(type: 'ReadAttributeRequestItemDVO');

  factory ReadAttributeRequestItemDVO.fromJson(Map json) => _$ReadAttributeRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ReadAttributeRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ProposeAttributeRequestItemDVO extends RequestItemDVODerivation {
  final AttributeQueryDVO query;
  final DraftAttributeDVO attribute;

  ProposeAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    required this.query,
    required this.attribute,
  }) : super(type: 'ProposeAttributeRequestItemDVO');

  factory ProposeAttributeRequestItemDVO.fromJson(Map json) => _$ProposeAttributeRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ProposeAttributeRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CreateAttributeRequestItemDVO extends RequestItemDVODerivation {
  final DraftAttributeDVO attribute;
  final String? sourceAttributeId;

  CreateAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    required this.attribute,
    this.sourceAttributeId,
  }) : super(type: 'CreateAttributeRequestItemDVO');

  factory CreateAttributeRequestItemDVO.fromJson(Map json) => _$CreateAttributeRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$CreateAttributeRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ShareAttributeRequestItemDVO extends RequestItemDVODerivation {
  final DraftIdentityAttributeDVO attribute;
  final String sourceAttributeId;

  ShareAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    required this.attribute,
    required this.sourceAttributeId,
  }) : super(type: 'ShareAttributeRequestItemDVO');

  factory ShareAttributeRequestItemDVO.fromJson(Map json) => _$ShareAttributeRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ShareAttributeRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class AuthenticationRequestItemDVO extends RequestItemDVODerivation {
  AuthenticationRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
  }) : super(type: 'AuthenticationRequestItemDVO');

  factory AuthenticationRequestItemDVO.fromJson(Map json) => _$AuthenticationRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$AuthenticationRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ConsentRequestItemDVO extends RequestItemDVODerivation {
  final String consent;
  final String? link;

  ConsentRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    required this.consent,
    this.link,
  }) : super(type: 'ConsentRequestItemDVO');

  factory ConsentRequestItemDVO.fromJson(Map json) => _$ConsentRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ConsentRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RegisterAttributeListenerRequestItemDVO extends RequestItemDVODerivation {
  final AttributeQueryDVO query;

  RegisterAttributeListenerRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    required this.query,
  }) : super(type: 'RegisterAttributeListenerRequestItemDVO');

  factory RegisterAttributeListenerRequestItemDVO.fromJson(Map json) =>
      _$RegisterAttributeListenerRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$RegisterAttributeListenerRequestItemDVOToJson(this);
}
