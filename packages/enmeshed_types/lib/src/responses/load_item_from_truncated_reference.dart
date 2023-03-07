import '../dtos/dtos.dart';

enum LoadItemFromTruncatedReferenceResponseType { Token, File, RelationshipTemplate, DeviceOnboardingInfo }

class LoadItemFromTruncatedReferenceResponse {
  final LoadItemFromTruncatedReferenceResponseType type;
  final Map<String, dynamic> _value;

  LoadItemFromTruncatedReferenceResponse({
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

  DeviceOnboardingInfoDTO get deviceOnboardingInfoValue {
    if (type != LoadItemFromTruncatedReferenceResponseType.DeviceOnboardingInfo) throw Exception('Not a deviceOnboardingInfo');
    return DeviceOnboardingInfoDTO.fromJson(_value);
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

  factory LoadItemFromTruncatedReferenceResponse.fromJson(Map<String, dynamic> json) => LoadItemFromTruncatedReferenceResponse(
        type: LoadItemFromTruncatedReferenceResponseType.values.byName(json['type']),
        value: json['value'],
      );

  Map<String, dynamic> toJson() => {'type': type.name, 'value': _value};

  @override
  String toString() => 'LoadItemFromTruncatedReferenceResponse(type: $type, value: $_value)';
}
