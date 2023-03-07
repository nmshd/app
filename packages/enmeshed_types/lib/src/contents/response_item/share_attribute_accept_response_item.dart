part of 'response_item.dart';

class ShareAttributeAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;

  ShareAttributeAcceptResponseItem({
    required this.attributeId,
  });

  factory ShareAttributeAcceptResponseItem.fromJson(Map<String, dynamic> json) {
    return ShareAttributeAcceptResponseItem(
      attributeId: json['attributeId'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ShareAttributeAcceptResponseItem',
        'attributeId': attributeId,
      };

  @override
  String toString() => 'ShareAttributeAcceptResponseItem(attributeId: $attributeId)';
}
