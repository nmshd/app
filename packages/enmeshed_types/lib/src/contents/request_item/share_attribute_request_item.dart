part of 'request_item.dart';

class ShareAttributeRequestItem extends RequestItemDerivation {
  final AbstractAttribute attribute;
  final String sourceAttributeId;
  final String? thirdPartyAddress;

  const ShareAttributeRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.attribute,
    required this.sourceAttributeId,
    this.thirdPartyAddress,
  });

  factory ShareAttributeRequestItem.fromJson(Map json) {
    return ShareAttributeRequestItem(
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
      mustBeAccepted: json['mustBeAccepted'],
      requireManualDecision: json['requireManualDecision'],
      attribute: AbstractAttribute.fromJson(json['attribute']),
      sourceAttributeId: json['sourceAttributeId'],
      thirdPartyAddress: json['thirdPartyAddress'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ShareAttributeRequestItem',
        'attribute': attribute.toJson(),
        'sourceAttributeId': sourceAttributeId,
        if (thirdPartyAddress != null) 'thirdPartyAddress': thirdPartyAddress,
      };

  @override
  List<Object?> get props => [super.props, attribute, sourceAttributeId, thirdPartyAddress];
}
