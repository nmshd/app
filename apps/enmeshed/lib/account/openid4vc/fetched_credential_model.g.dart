// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetched_credential_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map<String, dynamic> json) => Offer(
  metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
  offeredCredentialConfigurations: (json['offeredCredentialConfigurations'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      k,
      CredentialConfiguration.fromJson(e as Map<String, dynamic>),
    ),
  ),
  rawJson: json['rawJson'] as String,
  credentialOfferPayload: CredentialOfferPayload.fromJson(
    json['credentialOfferPayload'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
  'metadata': instance.metadata.toJson(),
  'offeredCredentialConfigurations': instance.offeredCredentialConfigurations.map((k, e) => MapEntry(k, e.toJson())),
  'credentialOfferPayload': instance.credentialOfferPayload.toJson(),
  'rawJson': instance.rawJson,
};

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
  credentialIssuer: CredentialIssuer.fromJson(
    json['credentialIssuer'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
  'credentialIssuer': instance.credentialIssuer.toJson(),
};

CredentialOfferPayload _$CredentialOfferPayloadFromJson(
  Map<String, dynamic> json,
) => CredentialOfferPayload(
  grants: (json['grants'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, Grant.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$CredentialOfferPayloadToJson(
  CredentialOfferPayload instance,
) => <String, dynamic>{
  'grants': instance.grants.map((k, e) => MapEntry(k, e.toJson())),
};

Grant _$GrantFromJson(Map<String, dynamic> json) => Grant(userPinRequired: json['userPinRequired'] as bool?);

Map<String, dynamic> _$GrantToJson(Grant instance) => <String, dynamic>{
  'userPinRequired': instance.userPinRequired,
};

CredentialIssuer _$CredentialIssuerFromJson(Map<String, dynamic> json) => CredentialIssuer(
  display: (json['display'] as List<dynamic>).map((e) => DisplayData.fromJson(e as Map<String, dynamic>)).toList(),
);

Map<String, dynamic> _$CredentialIssuerToJson(CredentialIssuer instance) => <String, dynamic>{
  'display': instance.display.map((e) => e.toJson()).toList(),
};

CredentialConfiguration _$CredentialConfigurationFromJson(
  Map<String, dynamic> json,
) => CredentialConfiguration(
  display: (json['display'] as List<dynamic>).map((e) => DisplayData.fromJson(e as Map<String, dynamic>)).toList(),
);

Map<String, dynamic> _$CredentialConfigurationToJson(
  CredentialConfiguration instance,
) => <String, dynamic>{
  'display': instance.display.map((e) => e.toJson()).toList(),
};

DisplayData _$DisplayDataFromJson(Map<String, dynamic> json) => DisplayData(
  name: json['name'] as String?,
  logo: json['logo'] == null ? null : WebImage.fromJson(json['logo'] as Map<String, dynamic>),
  backgroundImage: json['background_image'] == null ? null : WebImage.fromJson(json['background_image'] as Map<String, dynamic>),
  backgroundColor: json['background_color'] as String?,
  textColor: json['text_color'] as String?,
);

Map<String, dynamic> _$DisplayDataToJson(DisplayData instance) => <String, dynamic>{
  'name': instance.name,
  'logo': instance.logo?.toJson(),
  'background_image': instance.backgroundImage?.toJson(),
  'background_color': instance.backgroundColor,
  'text_color': instance.textColor,
};

WebImage _$WebImageFromJson(Map<String, dynamic> json) => WebImage(url: json['url'] as String?);

Map<String, dynamic> _$WebImageToJson(WebImage instance) => <String, dynamic>{
  'url': instance.url,
};
