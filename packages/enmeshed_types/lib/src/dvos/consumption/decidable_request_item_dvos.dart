part of '../content/request_item_dvos.dart';

sealed class DecidableRequestItemDVODerivation extends RequestItemDVODerivation {
  const DecidableRequestItemDVODerivation({
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
    super.requireManualDecision,
  });

  factory DecidableRequestItemDVODerivation.fromJson(Map json) => switch (json['type']) {
    'DecidableReadAttributeRequestItemDVO' => DecidableReadAttributeRequestItemDVO.fromJson(json),
    'DecidableProposeAttributeRequestItemDVO' => DecidableProposeAttributeRequestItemDVO.fromJson(json),
    'DecidableCreateAttributeRequestItemDVO' => DecidableCreateAttributeRequestItemDVO.fromJson(json),
    'DecidableShareAttributeRequestItemDVO' => DecidableShareAttributeRequestItemDVO.fromJson(json),
    'DecidableAuthenticationRequestItemDVO' => DecidableAuthenticationRequestItemDVO.fromJson(json),
    'DecidableConsentRequestItemDVO' => DecidableConsentRequestItemDVO.fromJson(json),
    'DecidableFreeTextRequestItemDVO' => DecidableFreeTextRequestItemDVO.fromJson(json),
    'DecidableRegisterAttributeListenerRequestItemDVO' => DecidableRegisterAttributeListenerRequestItemDVO.fromJson(json),
    'DecidableTransferFileOwnershipRequestItemDVO' => DecidableTransferFileOwnershipRequestItemDVO.fromJson(json),
    _ => throw Exception("Invalid type '${json['type']}'"),
  };

  @override
  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class DecidableReadAttributeRequestItemDVO extends DecidableRequestItemDVODerivation {
  final ProcessedAttributeQueryDVO query;

  const DecidableReadAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required this.query,
    super.requireManualDecision,
  }) : super(type: 'DecidableReadAttributeRequestItemDVO', isDecidable: true);

  factory DecidableReadAttributeRequestItemDVO.fromJson(Map json) => _$DecidableReadAttributeRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DecidableReadAttributeRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DecidableProposeAttributeRequestItemDVO extends DecidableRequestItemDVODerivation {
  final ProcessedAttributeQueryDVO query;
  final DraftAttributeDVO attribute;

  const DecidableProposeAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.query,
    required this.attribute,
  }) : super(type: 'DecidableProposeAttributeRequestItemDVO', isDecidable: true);

  factory DecidableProposeAttributeRequestItemDVO.fromJson(Map json) =>
      _$DecidableProposeAttributeRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DecidableProposeAttributeRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DecidableCreateAttributeRequestItemDVO extends DecidableRequestItemDVODerivation {
  final DraftAttributeDVO attribute;

  const DecidableCreateAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.attribute,
  }) : super(type: 'DecidableCreateAttributeRequestItemDVO', isDecidable: true);

  factory DecidableCreateAttributeRequestItemDVO.fromJson(Map json) =>
      _$DecidableCreateAttributeRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DecidableCreateAttributeRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DecidableDeleteAttributeRequestItemDVO extends DecidableRequestItemDVODerivation {
  final String attributeId;
  final LocalAttributeDVO attribute;

  const DecidableDeleteAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.attributeId,
    required this.attribute,
  }) : super(type: 'DecidableDeleteAttributeRequestItemDVO', isDecidable: true);

  factory DecidableDeleteAttributeRequestItemDVO.fromJson(Map json) =>
      _$DecidableDeleteAttributeRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DecidableDeleteAttributeRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DecidableShareAttributeRequestItemDVO extends DecidableRequestItemDVODerivation {
  final String sourceAttributeId;
  final DraftAttributeDVO attribute;
  final String? thirdPartyAddress;

  const DecidableShareAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.sourceAttributeId,
    required this.attribute,
    this.thirdPartyAddress,
  }) : super(type: 'DecidableShareAttributeRequestItemDVO', isDecidable: true);

  factory DecidableShareAttributeRequestItemDVO.fromJson(Map json) =>
      _$DecidableShareAttributeRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DecidableShareAttributeRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DecidableAuthenticationRequestItemDVO extends DecidableRequestItemDVODerivation {
  const DecidableAuthenticationRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    super.requireManualDecision,
  }) : super(type: 'DecidableAuthenticationRequestItemDVO', isDecidable: true);

  factory DecidableAuthenticationRequestItemDVO.fromJson(Map json) =>
      _$DecidableAuthenticationRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DecidableAuthenticationRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DecidableConsentRequestItemDVO extends DecidableRequestItemDVODerivation {
  final String consent;
  final String? link;

  const DecidableConsentRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.consent,
    this.link,
  }) : super(type: 'DecidableConsentRequestItemDVO', isDecidable: true);

  factory DecidableConsentRequestItemDVO.fromJson(Map json) => _$DecidableConsentRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DecidableConsentRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DecidableFreeTextRequestItemDVO extends DecidableRequestItemDVODerivation {
  final String freeText;

  const DecidableFreeTextRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.freeText,
  }) : super(type: 'DecidableFreeTextRequestItemDVO', isDecidable: true);

  factory DecidableFreeTextRequestItemDVO.fromJson(Map json) => _$DecidableFreeTextRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DecidableFreeTextRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DecidableRegisterAttributeListenerRequestItemDVO extends DecidableRequestItemDVODerivation {
  final AttributeQueryDVO query;

  const DecidableRegisterAttributeListenerRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.query,
  }) : super(type: 'DecidableRegisterAttributeListenerRequestItemDVO', isDecidable: true);

  factory DecidableRegisterAttributeListenerRequestItemDVO.fromJson(Map json) =>
      _$DecidableRegisterAttributeListenerRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DecidableRegisterAttributeListenerRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DecidableTransferFileOwnershipRequestItemDVO extends DecidableRequestItemDVODerivation {
  final String fileReference;
  final FileDVO file;

  const DecidableTransferFileOwnershipRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.fileReference,
    required this.file,
  }) : super(type: 'DecidableTransferFileOwnershipRequestItemDVO', isDecidable: true);

  factory DecidableTransferFileOwnershipRequestItemDVO.fromJson(Map json) =>
      _$DecidableTransferFileOwnershipRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DecidableTransferFileOwnershipRequestItemDVOToJson(this);
}
