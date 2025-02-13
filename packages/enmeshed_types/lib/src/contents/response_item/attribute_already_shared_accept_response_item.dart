part of 'response_item.dart';

class AttributeAlreadySharedAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;

  const AttributeAlreadySharedAcceptResponseItem({required this.attributeId});

  factory AttributeAlreadySharedAcceptResponseItem.fromJson(Map json) {
    return AttributeAlreadySharedAcceptResponseItem(attributeId: json['attributeId']);
  }

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), '@type': 'AttributeAlreadySharedAcceptResponseItem', 'attributeId': attributeId};

  @override
  List<Object?> get props => [super.props, attributeId];
}
