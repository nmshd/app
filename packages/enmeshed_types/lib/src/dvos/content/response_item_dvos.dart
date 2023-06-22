import 'package:enmeshed_types/src/dvos/data_view_object.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../contents/contents.dart';
import '../common/common.dart';
import '../consumption/consumption.dart';

part 'response_item_dvos.g.dart';

sealed class ResponseItemDVO extends DataViewObject {
  ResponseItemDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
  });

  factory ResponseItemDVO.fromJson(Map<String, dynamic> json) => switch (json['type']) {
        'ResponseItemGroupDVO' => ResponseItemGroupDVO.fromJson(json),
        _ => ResponseItemDVODerivation.fromJson(json),
      };
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class ResponseItemGroupDVO extends ResponseItemDVO {
  final List<ResponseItemDVODerivation> items;

  ResponseItemGroupDVO({
    required this.items,
  }) : super(id: 'n/a', type: 'ResponseItemGroupDVO');

  factory ResponseItemGroupDVO.fromJson(Map<String, dynamic> json) => _$ResponseItemGroupDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ResponseItemGroupDVOToJson(this);
}

sealed class ResponseItemDVODerivation extends ResponseItemDVO {
  final ResponseItemResult result;

  ResponseItemDVODerivation({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.result,
  });

  factory ResponseItemDVODerivation.fromJson(Map<String, dynamic> json) => switch (json['type']) {
        'RejectResponseItemDVO' => RejectResponseItemDVO.fromJson(json),
        'ErrorResponseItemDVO' => ErrorResponseItemDVO.fromJson(json),
        _ => throw Exception("Invalid type '${json['type']}'"),
      };

  @override
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class RejectResponseItemDVO extends ResponseItemDVODerivation {
  final String? code;
  final String? message;

  RejectResponseItemDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    this.code,
    this.message,
  }) : super(result: ResponseItemResult.Rejected);

  factory RejectResponseItemDVO.fromJson(Map<String, dynamic> json) => _$RejectResponseItemDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RejectResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ErrorResponseItemDVO extends ResponseItemDVODerivation {
  final String code;
  final String message;

  ErrorResponseItemDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.code,
    required this.message,
  }) : super(result: ResponseItemResult.Error);

  factory ErrorResponseItemDVO.fromJson(Map<String, dynamic> json) => _$ErrorResponseItemDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ErrorResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class AcceptResponseItemDVO extends ResponseItemDVODerivation {
  AcceptResponseItemDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
  }) : super(result: ResponseItemResult.Accepted);

  factory AcceptResponseItemDVO.fromJson(Map<String, dynamic> json) => switch (json['type']) {
        'AcceptResponseItemDVO' => _$AcceptResponseItemDVOFromJson(json),
        'ReadAttributeAcceptResponseItemDVO' => ReadAttributeAcceptResponseItemDVO.fromJson(json),
        'ProposeAttributeAcceptResponseItemDVO' => ProposeAttributeAcceptResponseItemDVO.fromJson(json),
        'CreateAttributeAcceptResponseItemDVO' => CreateAttributeAcceptResponseItemDVO.fromJson(json),
        'ShareAttributeAcceptResponseItemDVO' => ShareAttributeAcceptResponseItemDVO.fromJson(json),
        'RegisterAttributeListenerAcceptResponseItemDVO' => RegisterAttributeListenerAcceptResponseItemDVO.fromJson(json),
        _ => throw Exception("Invalid type '${json['type']}'"),
      };
  @override
  Map<String, dynamic> toJson() => _$AcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ReadAttributeAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String attributeId;
  final LocalAttributeDVO attribute;

  ReadAttributeAcceptResponseItemDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.attributeId,
    required this.attribute,
  });

  factory ReadAttributeAcceptResponseItemDVO.fromJson(Map<String, dynamic> json) => _$ReadAttributeAcceptResponseItemDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ReadAttributeAcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ProposeAttributeAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String attributeId;
  final LocalAttributeDVO attribute;

  ProposeAttributeAcceptResponseItemDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.attributeId,
    required this.attribute,
  });

  factory ProposeAttributeAcceptResponseItemDVO.fromJson(Map<String, dynamic> json) => _$ProposeAttributeAcceptResponseItemDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProposeAttributeAcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CreateAttributeAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String attributeId;
  final LocalAttributeDVO attribute;

  CreateAttributeAcceptResponseItemDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.attributeId,
    required this.attribute,
  });

  factory CreateAttributeAcceptResponseItemDVO.fromJson(Map<String, dynamic> json) => _$CreateAttributeAcceptResponseItemDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CreateAttributeAcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ShareAttributeAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String attributeId;
  final LocalAttributeDVO attribute;

  ShareAttributeAcceptResponseItemDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.attributeId,
    required this.attribute,
  });

  factory ShareAttributeAcceptResponseItemDVO.fromJson(Map<String, dynamic> json) => _$ShareAttributeAcceptResponseItemDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ShareAttributeAcceptResponseItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RegisterAttributeListenerAcceptResponseItemDVO extends AcceptResponseItemDVO {
  final String listenerId;
  final LocalAttributeListenerDVO listener;

  RegisterAttributeListenerAcceptResponseItemDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.listenerId,
    required this.listener,
  });

  factory RegisterAttributeListenerAcceptResponseItemDVO.fromJson(Map<String, dynamic> json) =>
      _$RegisterAttributeListenerAcceptResponseItemDVOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RegisterAttributeListenerAcceptResponseItemDVOToJson(this);
}
