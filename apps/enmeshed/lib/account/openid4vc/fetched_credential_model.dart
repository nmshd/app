import 'package:json_annotation/json_annotation.dart';

part 'fetched_credential_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Offer {
  final Metadata metadata;

  @JsonKey(name: 'offeredCredentialConfigurations')
  final Map<String, CredentialConfiguration> offeredCredentialConfigurations;

  final CredentialOfferPayload credentialOfferPayload;

  /// Keep the full raw JSON for later use
  @JsonKey(includeFromJson: true)
  final String rawJson;

  Offer({
    required this.metadata,
    required this.offeredCredentialConfigurations,
    required this.rawJson,
    required this.credentialOfferPayload,
  });

  factory Offer.fromJson(Map<String, dynamic> json, {required String raw}) => Offer(
    metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    offeredCredentialConfigurations: (json['offeredCredentialConfigurations'] as Map<String, dynamic>).map(
      (k, v) => MapEntry(
        k,
        CredentialConfiguration.fromJson(v as Map<String, dynamic>),
      ),
    ),
    credentialOfferPayload: CredentialOfferPayload.fromJson(json['credentialOfferPayload'] as Map<String, dynamic>),
    rawJson: raw,
  );
}

@JsonSerializable(explicitToJson: true)
class Metadata {
  final CredentialIssuer credentialIssuer;

  Metadata({required this.credentialIssuer});

  factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CredentialOfferPayload {
  final Map<String, Grant> grants;

  CredentialOfferPayload({required this.grants});

  factory CredentialOfferPayload.fromJson(Map<String, dynamic> json) => _$CredentialOfferPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialOfferPayloadToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Grant {
  final bool? userPinRequired;

  Grant({this.userPinRequired});

  factory Grant.fromJson(Map<String, dynamic> json) => _$GrantFromJson(json);
  Map<String, dynamic> toJson() => _$GrantToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CredentialIssuer {
  final List<DisplayData> display;

  CredentialIssuer({required this.display});

  factory CredentialIssuer.fromJson(Map<String, dynamic> json) => _$CredentialIssuerFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialIssuerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CredentialConfiguration {
  final List<DisplayData> display;

  CredentialConfiguration({required this.display});

  factory CredentialConfiguration.fromJson(Map<String, dynamic> json) => _$CredentialConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DisplayData {
  final String? name;
  final WebImage? logo;

  @JsonKey(name: 'background_image')
  final WebImage? backgroundImage;

  @JsonKey(name: 'background_color')
  final String? backgroundColor;

  @JsonKey(name: 'text_color')
  final String? textColor;

  DisplayData({this.name, this.logo, this.backgroundImage, this.backgroundColor, this.textColor});

  factory DisplayData.fromJson(Map<String, dynamic> json) => _$DisplayDataFromJson(json);
  Map<String, dynamic> toJson() => _$DisplayDataToJson(this);
}

@JsonSerializable()
class WebImage {
  final String? url;

  WebImage({this.url});

  factory WebImage.fromJson(Map<String, dynamic> json) => _$WebImageFromJson(json);
  Map<String, dynamic> toJson() => _$WebImageToJson(this);
}
