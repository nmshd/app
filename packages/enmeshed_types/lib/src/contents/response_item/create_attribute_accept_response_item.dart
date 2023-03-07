part of 'response_item.dart';

class CreateAttributeAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;

  CreateAttributeAcceptResponseItem({
    required this.attributeId,
  });

  factory CreateAttributeAcceptResponseItem.fromJson(Map<String, dynamic> json) {
    return CreateAttributeAcceptResponseItem(
      attributeId: json['attributeId'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'CreateAttributeAcceptResponseItem',
        'attributeId': attributeId,
      };

  @override
  String toString() => 'CreateAttributeAcceptResponseItem(attributeId: $attributeId)';
}
