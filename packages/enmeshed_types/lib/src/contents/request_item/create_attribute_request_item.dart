part of 'request_item.dart';

class CreateAttributeRequestItem extends RequestItemDerivation {
  final AbstractAttribute attribute;

  const CreateAttributeRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.attribute,
  });

  factory CreateAttributeRequestItem.fromJson(Map json) {
    return CreateAttributeRequestItem(
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
      mustBeAccepted: json['mustBeAccepted'],
      requireManualDecision: json['requireManualDecision'],
      attribute: AbstractAttribute.fromJson(json['attribute']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), '@type': 'CreateAttributeRequestItem', 'attribute': attribute.toJson()};

  @override
  List<Object?> get props => [super.props, attribute];
}
