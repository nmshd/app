import '../abstract_attribute.dart';
import 'accept_response_item.dart';

class ReadAttributeAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;
  final AbstractAttribute attribute;
  final String? thirdPartyAddress;

  const ReadAttributeAcceptResponseItem({required this.attributeId, required this.attribute, this.thirdPartyAddress});

  factory ReadAttributeAcceptResponseItem.fromJson(Map json) {
    return ReadAttributeAcceptResponseItem(
      attributeId: json['attributeId'],
      attribute: AbstractAttribute.fromJson(json['attribute']),
      thirdPartyAddress: json['thirdPartyAddress'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    '@type': 'ReadAttributeAcceptResponseItem',
    'attributeId': attributeId,
    'attribute': attribute.toJson(),
    if (thirdPartyAddress != null) 'thirdPartyAddress': thirdPartyAddress,
  };

  @override
  List<Object?> get props => [super.props, attributeId, attribute, thirdPartyAddress];
}
