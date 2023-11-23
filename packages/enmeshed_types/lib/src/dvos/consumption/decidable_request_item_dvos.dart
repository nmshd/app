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
    required this.attribute,
  }) : super(type: 'DecidableCreateAttributeRequestItemDVO', isDecidable: true);

  factory DecidableCreateAttributeRequestItemDVO.fromJson(Map json) =>
      _$DecidableCreateAttributeRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DecidableCreateAttributeRequestItemDVOToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DecidableShareAttributeRequestItemDVO extends DecidableRequestItemDVODerivation {
  final String sourceAttributeId;
  final DraftAttributeDVO attribute;

  const DecidableShareAttributeRequestItemDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    super.date,
    super.error,
    super.warning,
    required super.mustBeAccepted,
    required this.sourceAttributeId,
    required this.attribute,
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
    required this.query,
  }) : super(type: 'DecidableRegisterAttributeListenerRequestItemDVO', isDecidable: true);

  factory DecidableRegisterAttributeListenerRequestItemDVO.fromJson(Map json) =>
      _$DecidableRegisterAttributeListenerRequestItemDVOFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$DecidableRegisterAttributeListenerRequestItemDVOToJson(this);
}
