import 'package:json_annotation/json_annotation.dart';

import '../../contents/contents.dart';
import '../common/common.dart';
import '../consumption/consumption.dart';
import '../data_view_object.dart';
import '../../contents/response_items/form_field_accept_response_item.dart';

part 'response_item_dvos.g.dart';

sealed class ResponseItemDVO extends DataViewObject {
  const ResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
  });

  factory ResponseItemDVO.fromJson(Map json) => switch (json['type']) {
    'ResponseItemGroupDVO' => ResponseItemGroupDVO.fromJson(json),
    _ => ResponseItemDVODerivation.fromJson(json),
  };
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class ResponseItemGroupDVO extends ResponseItemDVO {
  final List<ResponseItemDVODerivation> items;

  const ResponseItemGroupDVO({required this.items}) : super(id: 'n/a', name: 'n/a', type: 'ResponseItemGroupDVO');

  factory ResponseItemGroupDVO.fromJson(Map json) => _$ResponseItemGroupDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ResponseItemGroupDVOToJson(this);
}

sealed class ResponseItemDVODerivation extends ResponseItemDVO {
  final ResponseItemResult result;

  const ResponseItemDVODerivation({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.result,
  });

  factory ResponseItemDVODerivation.fromJson(Map json) => switch (json['type']) {
    'RejectResponseItemDVO' => RejectResponseItemDVO.fromJson(json),
    'ErrorResponseItemDVO' => ErrorResponseItemDVO.fromJson(json),
    _ => AcceptResponseItemDVO.fromJson(json),
  };

  @override
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class RejectResponseItemDVO extends ResponseItemDVODerivation {
  final String? code;
  final String? message;

  const RejectResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    this.code,
    this.message,
  }) : super(result: ResponseItemResult.Rejected);

  factory RejectResponseItemDVO.fromJson(Map json) => _$RejectResponseItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$RejectResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ErrorResponseItemDVO extends ResponseItemDVODerivation {
  final String code;
  final String message;

  const ErrorResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.code,
    required this.message,
  }) : super(result: ResponseItemResult.Error);

  factory ErrorResponseItemDVO.fromJson(Map json) => _$ErrorResponseItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ErrorResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class AcceptResponseItemDVO extends ResponseItemDVODerivation {
  const AcceptResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
  }) : super(result: ResponseItemResult.Accepted);

  factory AcceptResponseItemDVO.fromJson(Map json) => switch (json['type']) {
    'AcceptResponseItemDVO' => _$AcceptResponseItemDVOFromJson(Map<String, dynamic>.from(json)),
    'ReadAttributeAcceptResponseItemDVO' => ReadAttributeAcceptResponseItemDVO.fromJson(json),
    'ProposeAttributeAcceptResponseItemDVO' => ProposeAttributeAcceptResponseItemDVO.fromJson(json),
    'CreateAttributeAcceptResponseItemDVO' => CreateAttributeAcceptResponseItemDVO.fromJson(json),
    'DeleteAttributeAcceptResponseItemDVO' => DeleteAttributeAcceptResponseItemDVO.fromJson(json),
    'ShareAttributeAcceptResponseItemDVO' => ShareAttributeAcceptResponseItemDVO.fromJson(json),
    'FormFieldAcceptResponseItemDVO' => FormFieldAcceptResponseItemDVO.fromJson(json),
    'FreeTextAcceptResponseItemDVO' => FreeTextAcceptResponseItemDVO.fromJson(json),
    'RegisterAttributeListenerAcceptResponseItemDVO' => RegisterAttributeListenerAcceptResponseItemDVO.fromJson(json),
    'TransferFileOwnershipAcceptResponseItemDVO' => TransferFileOwnershipAcceptResponseItemDVO.fromJson(json),
    'AttributeSuccessionAcceptResponseItemDVO' => AttributeSuccessionAcceptResponseItemDVO.fromJson(json),
    'AttributeAlreadySharedAcceptResponseItemDVO' => AttributeAlreadySharedAcceptResponseItemDVO.fromJson(json),
    _ => throw Exception("Invalid type '${json['type']}'"),
  };
  @override
  Map<String, dynamic> toJson() => _$AcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ReadAttributeAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String attributeId;
  final LocalAttributeDVO attribute;
  final String? thirdPartyAddress;

  const ReadAttributeAcceptResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.attributeId,
    required this.attribute,
    this.thirdPartyAddress,
  });

  factory ReadAttributeAcceptResponseItemDVO.fromJson(Map json) => _$ReadAttributeAcceptResponseItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ReadAttributeAcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ProposeAttributeAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String attributeId;
  final LocalAttributeDVO attribute;

  const ProposeAttributeAcceptResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.attributeId,
    required this.attribute,
  });

  factory ProposeAttributeAcceptResponseItemDVO.fromJson(Map json) =>
      _$ProposeAttributeAcceptResponseItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ProposeAttributeAcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CreateAttributeAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String attributeId;
  final LocalAttributeDVO attribute;

  const CreateAttributeAcceptResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.attributeId,
    required this.attribute,
  });

  factory CreateAttributeAcceptResponseItemDVO.fromJson(Map json) => _$CreateAttributeAcceptResponseItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$CreateAttributeAcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DeleteAttributeAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String deletionDate;

  const DeleteAttributeAcceptResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.deletionDate,
  });

  factory DeleteAttributeAcceptResponseItemDVO.fromJson(Map json) => _$DeleteAttributeAcceptResponseItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DeleteAttributeAcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ShareAttributeAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String attributeId;
  final LocalAttributeDVO attribute;

  const ShareAttributeAcceptResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.attributeId,
    required this.attribute,
  });

  factory ShareAttributeAcceptResponseItemDVO.fromJson(Map json) => _$ShareAttributeAcceptResponseItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$ShareAttributeAcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class FormFieldAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final FormFieldAcceptResponseType response;

  const FormFieldAcceptResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.response,
  });

  factory FormFieldAcceptResponseItemDVO.fromJson(Map json) => _$FormFieldAcceptResponseItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$FormFieldAcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class FreeTextAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String freeText;

  const FreeTextAcceptResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.freeText,
  });

  factory FreeTextAcceptResponseItemDVO.fromJson(Map json) => _$FreeTextAcceptResponseItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$FreeTextAcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RegisterAttributeListenerAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String listenerId;
  final LocalAttributeListenerDVO listener;

  const RegisterAttributeListenerAcceptResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.listenerId,
    required this.listener,
  });

  factory RegisterAttributeListenerAcceptResponseItemDVO.fromJson(Map json) =>
      _$RegisterAttributeListenerAcceptResponseItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$RegisterAttributeListenerAcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class TransferFileOwnershipAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String attributeId;
  final LocalAttributeDVO? repositoryAttribute;
  final String sharedAttributeId;
  final LocalAttributeDVO sharedAttribute;

  const TransferFileOwnershipAcceptResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.attributeId,
    required this.repositoryAttribute,
    required this.sharedAttributeId,
    required this.sharedAttribute,
  });

  factory TransferFileOwnershipAcceptResponseItemDVO.fromJson(Map json) =>
      _$TransferFileOwnershipAcceptResponseItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$TransferFileOwnershipAcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class AttributeSuccessionAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String predecessorId;
  final String successorId;
  final LocalAttributeDVO predecessor;
  final LocalAttributeDVO successor;

  const AttributeSuccessionAcceptResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.predecessorId,
    required this.successorId,
    required this.predecessor,
    required this.successor,
  });

  factory AttributeSuccessionAcceptResponseItemDVO.fromJson(Map json) =>
      _$AttributeSuccessionAcceptResponseItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$AttributeSuccessionAcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class AttributeAlreadySharedAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String attributeId;
  final LocalAttributeDVO attribute;

  const AttributeAlreadySharedAcceptResponseItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.attributeId,
    required this.attribute,
  });

  factory AttributeAlreadySharedAcceptResponseItemDVO.fromJson(Map json) =>
      _$AttributeAlreadySharedAcceptResponseItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$AttributeAlreadySharedAcceptResponseItemDVOToJson(this);
}
