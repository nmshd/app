part of 'response_item.dart';

class ProposeAttributeAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;
  final AbstractAttribute attribute;

  const ProposeAttributeAcceptResponseItem({
    required this.attributeId,
    required this.attribute,
  });

  factory ProposeAttributeAcceptResponseItem.fromJson(Map json) {
    return ProposeAttributeAcceptResponseItem(
      attributeId: json['attributeId'],
      attribute: AbstractAttribute.fromJson(json['attribute']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ProposeAttributeAcceptResponseItem',
        'attributeId': attributeId,
        'attribute': attribute.toJson(),
      };

  @override
  List<Object?> get props => [super.props, attributeId, attribute];
}
