import 'package:equatable/equatable.dart';

import '../dtos/dtos.dart';

enum LoadItemFromTruncatedReferenceResponseType { Token, File, RelationshipTemplate, DeviceOnboardingInfo }

class LoadItemFromTruncatedReferenceResponse extends Equatable {
  final LoadItemFromTruncatedReferenceResponseType type;
  final Map<String, dynamic> _value;

  const LoadItemFromTruncatedReferenceResponse({
    required this.type,
    required Map<String, dynamic> value,
  }) : _value = value;

  TokenDTO get tokenValue {
    if (type != LoadItemFromTruncatedReferenceResponseType.Token) throw Exception('Not a token');
    return TokenDTO.fromJson(_value);
  }

  FileDTO get fileValue {
    if (type != LoadItemFromTruncatedReferenceResponseType.File) throw Exception('Not a file');
    return FileDTO.fromJson(_value);
  }

  RelationshipTemplateDTO get relationshipTemplateValue {
    if (type != LoadItemFromTruncatedReferenceResponseType.RelationshipTemplate) throw Exception('Not a relationshipTemplate');
    return RelationshipTemplateDTO.fromJson(_value);
  }

  DeviceSharedSecret get deviceOnboardingInfoValue {
    if (type != LoadItemFromTruncatedReferenceResponseType.DeviceOnboardingInfo) throw Exception('Not a deviceOnboardingInfo');
    return DeviceSharedSecret.fromJson(_value);
  }

  dynamic get valueAsObject {
    switch (type) {
      case LoadItemFromTruncatedReferenceResponseType.Token:
        return tokenValue;
      case LoadItemFromTruncatedReferenceResponseType.File:
        return fileValue;
      case LoadItemFromTruncatedReferenceResponseType.RelationshipTemplate:
        return relationshipTemplateValue;
      case LoadItemFromTruncatedReferenceResponseType.DeviceOnboardingInfo:
        return deviceOnboardingInfoValue;
    }
  }

  factory LoadItemFromTruncatedReferenceResponse.fromJson(Map json) => LoadItemFromTruncatedReferenceResponse(
        type: LoadItemFromTruncatedReferenceResponseType.values.byName(json['type']),
        value: Map<String, dynamic>.from(json['value']),
      );

  Map<String, dynamic> toJson() => {'type': type.name, 'value': _value};

  @override
  String toString() => 'LoadItemFromTruncatedReferenceResponse(type: $type, value: $_value)';

  @override
  List<Object?> get props => [type, _value];
}
