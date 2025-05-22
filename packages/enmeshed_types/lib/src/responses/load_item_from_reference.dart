import 'package:equatable/equatable.dart';

import '../dtos/dtos.dart';

enum LoadItemFromReferenceResponseType { Token, File, RelationshipTemplate, DeviceOnboardingInfo }

class LoadItemFromReferenceResponse extends Equatable {
  final LoadItemFromReferenceResponseType type;
  final Map<String, dynamic> _value;

  const LoadItemFromReferenceResponse({required this.type, required Map<String, dynamic> value}) : _value = value;

  TokenDTO get tokenValue {
    if (type != LoadItemFromReferenceResponseType.Token) throw Exception('Not a token');
    return TokenDTO.fromJson(_value);
  }

  FileDTO get fileValue {
    if (type != LoadItemFromReferenceResponseType.File) throw Exception('Not a file');
    return FileDTO.fromJson(_value);
  }

  RelationshipTemplateDTO get relationshipTemplateValue {
    if (type != LoadItemFromReferenceResponseType.RelationshipTemplate) throw Exception('Not a relationshipTemplate');
    return RelationshipTemplateDTO.fromJson(_value);
  }

  DeviceSharedSecret get deviceOnboardingInfoValue {
    if (type != LoadItemFromReferenceResponseType.DeviceOnboardingInfo) throw Exception('Not a deviceOnboardingInfo');
    return DeviceSharedSecret.fromJson(_value);
  }

  dynamic get valueAsObject => switch (type) {
    LoadItemFromReferenceResponseType.Token => tokenValue,
    LoadItemFromReferenceResponseType.File => fileValue,
    LoadItemFromReferenceResponseType.RelationshipTemplate => relationshipTemplateValue,
    LoadItemFromReferenceResponseType.DeviceOnboardingInfo => deviceOnboardingInfoValue,
  };

  factory LoadItemFromReferenceResponse.fromJson(Map json) => LoadItemFromReferenceResponse(
    type: LoadItemFromReferenceResponseType.values.byName(json['type']),
    value: Map<String, dynamic>.from(json['value']),
  );

  Map<String, dynamic> toJson() => {'type': type.name, 'value': _value};

  @override
  List<Object?> get props => [type, _value];
}
