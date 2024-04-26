part of 'request_item.dart';

class ProposeAttributeRequestItem extends RequestItemDerivation {
  final AttributeQuery query;
  final AbstractAttribute attribute;

  const ProposeAttributeRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.query,
    required this.attribute,
  });

  factory ProposeAttributeRequestItem.fromJson(Map json) {
    return ProposeAttributeRequestItem(
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
      mustBeAccepted: json['mustBeAccepted'],
      requireManualDecision: json['requireManualDecision'],
      query: AttributeQuery.fromJson(json['query']),
      attribute: AbstractAttribute.fromJson(json['attribute']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ProposeAttributeRequestItem',
        'query': query.toJson(),
        'attribute': attribute.toJson(),
      };

  @override
  List<Object?> get props => [super.props, query, attribute];
}
