part of 'request_item.dart';

class ShareAttributeRequestItem extends RequestItemDerivation {
  final AbstractAttribute attribute;
  final String sourceAttributeId;

  const ShareAttributeRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.attribute,
    required this.sourceAttributeId,
  });

  factory ShareAttributeRequestItem.fromJson(Map json) {
    return ShareAttributeRequestItem(
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'],
      mustBeAccepted: json['mustBeAccepted'],
      requireManualDecision: json['requireManualDecision'],
      attribute: AbstractAttribute.fromJson(json['attribute']),
      sourceAttributeId: json['sourceAttributeId'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ShareAttributeRequestItem',
        'attribute': attribute.toJson(),
        'sourceAttributeId': sourceAttributeId,
      };

  @override
  String toString() => 'ShareAttributeRequestItem(attribute: $attribute, sourceAttributeId: $sourceAttributeId)';

  @override
  List<Object?> get props => [super.props, attribute, sourceAttributeId];
}
