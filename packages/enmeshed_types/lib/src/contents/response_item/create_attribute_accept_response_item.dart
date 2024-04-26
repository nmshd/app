part of 'response_item.dart';

class CreateAttributeAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;

  const CreateAttributeAcceptResponseItem({
    required this.attributeId,
  });

  factory CreateAttributeAcceptResponseItem.fromJson(Map json) {
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
  List<Object?> get props => [super.props, attributeId];
}
