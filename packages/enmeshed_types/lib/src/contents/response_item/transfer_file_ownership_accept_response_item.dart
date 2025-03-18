part of 'response_item.dart';

class TransferFileOwnershipAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;
  final AbstractAttribute attribute;

  const TransferFileOwnershipAcceptResponseItem({required this.attributeId, required this.attribute});

  factory TransferFileOwnershipAcceptResponseItem.fromJson(Map json) {
    return TransferFileOwnershipAcceptResponseItem(attributeId: json['attributeId'], attribute: AbstractAttribute.fromJson(json['attribute']));
  }

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    '@type': 'TransferFileOwnershipAcceptResponseItem',
    'attributeId': attributeId,
    'attribute': attribute.toJson(),
  };

  @override
  List<Object?> get props => [super.props, attributeId, attribute];
}
