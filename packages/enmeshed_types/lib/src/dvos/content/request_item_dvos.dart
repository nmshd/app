import 'package:json_annotation/json_annotation.dart';

import '../../contents/request_items/form_field_settings/form_field_settings.dart';
import '../common/common.dart';
import '../consumption/consumption.dart';
import '../data_view_object.dart';
import '../transport/file_dvo.dart';
import 'attribute_dvos.dart';
import 'attribute_query_dvos.dart';
import 'response_item_dvos.dart';

part 'request_item_dvos.g.dart';

sealed class RequestItemDVO extends DataViewObject {
  final bool isDecidable;

  const RequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.isDecidable,
  });

  factory RequestItemDVO.fromJson(Map json) {
    final type = json['type'];
    if (type == 'RequestItemGroupDVO') return RequestItemGroupDVO.fromJson(json);
    return RequestItemDVODerivation.fromJson(json);
  }

  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class RequestItemGroupDVO extends RequestItemDVO {
  final List<RequestItemDVODerivation> items;
  final String? title;
  final ResponseItemGroupDVO? response;

  const RequestItemGroupDVO({required super.isDecidable, required this.items, this.title, super.description, this.response})
    : super(id: 'n/a', name: 'n/a', type: 'RequestItemGroupDVO');

  factory RequestItemGroupDVO.fromJson(Map json) => _$RequestItemGroupDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$RequestItemGroupDVOToJson(this);
}

sealed class RequestItemDVODerivation extends RequestItemDVO {
  final ResponseItemDVO? response;
  final bool mustBeAccepted;
  final bool? requireManualDecision;

  const RequestItemDVODerivation({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required super.isDecidable,
    required this.mustBeAccepted,
    this.response,
    this.requireManualDecision,
  });

  factory RequestItemDVODerivation.fromJson(Map json) {
    return switch (json['type']) {
      'ReadAttributeRequestItemDVO' => ReadAttributeRequestItemDVO.fromJson(json),
      'ProposeAttributeRequestItemDVO' => ProposeAttributeRequestItemDVO.fromJson(json),
      'CreateAttributeRequestItemDVO' => CreateAttributeRequestItemDVO.fromJson(json),
      'DeleteAttributeRequestItemDVO' => DeleteAttributeRequestItemDVO.fromJson(json),
      'ShareAttributeRequestItemDVO' => ShareAttributeRequestItemDVO.fromJson(json),
      'AuthenticationRequestItemDVO' => AuthenticationRequestItemDVO.fromJson(json),
      'ConsentRequestItemDVO' => ConsentRequestItemDVO.fromJson(json),
      'FormFieldRequestItemDVO' => FormFieldRequestItemDVO.fromJson(json),
      'RegisterAttributeListenerRequestItemDVO' => RegisterAttributeListenerRequestItemDVO.fromJson(json),
      'TransferFileOwnershipRequestItemDVO' => TransferFileOwnershipRequestItemDVO.fromJson(json),
      _ => throw Exception("Invalid type '${json['type']}'"),
    };
  }

  @override
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class ReadAttributeRequestItemDVO extends RequestItemDVODerivation {
  final AttributeQueryDVO query;

  const ReadAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    super.response,
    super.requireManualDecision,
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
  final bool proposedValueOverruled;

  const ProposeAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    super.response,
    super.requireManualDecision,
    required this.query,
    required this.attribute,
    required this.proposedValueOverruled,
  }) : super(type: 'ProposeAttributeRequestItemDVO');

  factory ProposeAttributeRequestItemDVO.fromJson(Map json) => _$ProposeAttributeRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ProposeAttributeRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CreateAttributeRequestItemDVO extends RequestItemDVODerivation {
  final DraftAttributeDVO attribute;
  final String? sourceAttributeId;

  const CreateAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    super.response,
    super.requireManualDecision,
    required this.attribute,
    this.sourceAttributeId,
  }) : super(type: 'CreateAttributeRequestItemDVO');

  factory CreateAttributeRequestItemDVO.fromJson(Map json) => _$CreateAttributeRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$CreateAttributeRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DeleteAttributeRequestItemDVO extends RequestItemDVODerivation {
  final String attributeId;
  final LocalAttributeDVO attribute;

  const DeleteAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    super.response,
    super.requireManualDecision,
    required this.attributeId,
    required this.attribute,
  }) : super(type: 'DeleteAttributeRequestItemDVO');

  factory DeleteAttributeRequestItemDVO.fromJson(Map json) => _$DeleteAttributeRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DeleteAttributeRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ShareAttributeRequestItemDVO extends RequestItemDVODerivation {
  final DraftIdentityAttributeDVO attribute;
  final String sourceAttributeId;
  final String? thirdPartyAddress;

  const ShareAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    super.response,
    super.requireManualDecision,
    required this.attribute,
    required this.sourceAttributeId,
    this.thirdPartyAddress,
  }) : super(type: 'ShareAttributeRequestItemDVO');

  factory ShareAttributeRequestItemDVO.fromJson(Map json) => _$ShareAttributeRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ShareAttributeRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class AuthenticationRequestItemDVO extends RequestItemDVODerivation {
  final String title;

  const AuthenticationRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    super.response,
    super.requireManualDecision,
    required this.title,
  }) : super(type: 'AuthenticationRequestItemDVO');

  factory AuthenticationRequestItemDVO.fromJson(Map json) => _$AuthenticationRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$AuthenticationRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ConsentRequestItemDVO extends RequestItemDVODerivation {
  final String consent;
  final String? link;
  final String? linkDisplayText;

  const ConsentRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    super.response,
    super.requireManualDecision,
    required this.consent,
    this.link,
    this.linkDisplayText,
  }) : super(type: 'ConsentRequestItemDVO');

  factory ConsentRequestItemDVO.fromJson(Map json) => _$ConsentRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ConsentRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class FormFieldRequestItemDVO extends RequestItemDVODerivation {
  final String title;
  final FormFieldSettings settings;

  const FormFieldRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    super.response,
    super.requireManualDecision,
    required this.title,
    required this.settings,
  }) : super(type: 'FormFieldRequestItemDVO');

  factory FormFieldRequestItemDVO.fromJson(Map json) => _$FormFieldRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$FormFieldRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RegisterAttributeListenerRequestItemDVO extends RequestItemDVODerivation {
  final AttributeQueryDVO query;

  const RegisterAttributeListenerRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    super.response,
    super.requireManualDecision,
    required this.query,
  }) : super(type: 'RegisterAttributeListenerRequestItemDVO');

  factory RegisterAttributeListenerRequestItemDVO.fromJson(Map json) =>
      _$RegisterAttributeListenerRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$RegisterAttributeListenerRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class TransferFileOwnershipRequestItemDVO extends RequestItemDVODerivation {
  final String fileReference;
  final FileDVO file;

  const TransferFileOwnershipRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required super.isDecidable,
    super.response,
    super.requireManualDecision,
    required this.fileReference,
    required this.file,
  }) : super(type: 'TransferFileOwnershipRequestItemDVO');

  factory TransferFileOwnershipRequestItemDVO.fromJson(Map json) => _$TransferFileOwnershipRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$TransferFileOwnershipRequestItemDVOToJson(this);
}
