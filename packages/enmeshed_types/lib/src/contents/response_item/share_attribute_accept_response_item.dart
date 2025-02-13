part of 'response_item.dart';

class ShareAttributeAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;

  const ShareAttributeAcceptResponseItem({required this.attributeId});

  factory ShareAttributeAcceptResponseItem.fromJson(Map json) {
    return ShareAttributeAcceptResponseItem(attributeId: json['attributeId']);
  }

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), '@type': 'ShareAttributeAcceptResponseItem', 'attributeId': attributeId};

  @override
  List<Object?> get props => [super.props, attributeId];
}
