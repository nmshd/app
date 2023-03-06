part of 'response_item.dart';

class SucceedAttributeAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;

  SucceedAttributeAcceptResponseItem({
    required this.attributeId,
  });

  factory SucceedAttributeAcceptResponseItem.fromJson(Map<String, dynamic> json) {
    return SucceedAttributeAcceptResponseItem(
      attributeId: json['attributeId'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'SucceedAttributeAcceptResponseItem',
        'attributeId': attributeId,
      };

  @override
  String toString() => 'SucceedAttributeAcceptResponseItem(attributeId: $attributeId)';
}
