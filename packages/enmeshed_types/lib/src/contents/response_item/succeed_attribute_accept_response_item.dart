part of 'response_item.dart';

class SucceedAttributeAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;

  const SucceedAttributeAcceptResponseItem({
    required this.attributeId,
  });

  factory SucceedAttributeAcceptResponseItem.fromJson(Map json) {
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

  @override
  List<Object?> get props => [super.props, attributeId];
}
