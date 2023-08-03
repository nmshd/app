part of 'request_item.dart';

class SucceedAttributeRequestItem extends RequestItemDerivation {
  final String succeededAttributeId;
  final AbstractAttribute attribute;

  const SucceedAttributeRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.succeededAttributeId,
    required this.attribute,
  });

  factory SucceedAttributeRequestItem.fromJson(Map json) {
    return SucceedAttributeRequestItem(
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
      mustBeAccepted: json['mustBeAccepted'],
      requireManualDecision: json['requireManualDecision'],
      succeededAttributeId: json['succeededAttributeId'],
      attribute: AbstractAttribute.fromJson(json['attribute']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'SucceedAttributeRequestItem',
        'succeededAttributeId': succeededAttributeId,
        'attribute': attribute.toJson(),
      };

  @override
  List<Object?> get props => [super.props, succeededAttributeId, attribute];
}
