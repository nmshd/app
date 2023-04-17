part of 'response_item.dart';

class ReadAttributeAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;
  final AbstractAttribute attribute;

  const ReadAttributeAcceptResponseItem({
    required this.attributeId,
    required this.attribute,
  });

  factory ReadAttributeAcceptResponseItem.fromJson(Map<String, dynamic> json) {
    return ReadAttributeAcceptResponseItem(
      attributeId: json['attributeId'],
      attribute: AbstractAttribute.fromJson(json['attribute']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ReadAttributeAcceptResponseItem',
        'attributeId': attributeId,
        'attribute': attribute.toJson(),
      };

  @override
  String toString() => 'ReadAttributeAcceptResponseItem(attributeId: $attributeId, attribute: $attribute)';

  @override
  List<Object?> get props => [super.props, attributeId, attribute];
}
