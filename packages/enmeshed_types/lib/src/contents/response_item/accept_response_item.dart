part of 'response_item.dart';

class AcceptResponseItem extends ResponseItemDerivation {
  const AcceptResponseItem() : super(result: ResponseItemResult.Accepted);

  factory AcceptResponseItem.fromJson(Map<String, dynamic> json) {
    final type = json['@type'];

    if (type == 'AcceptResponseItem') return const AcceptResponseItem();

    switch (type) {
      case 'CreateAttributeAcceptResponseItem':
        return CreateAttributeAcceptResponseItem.fromJson(json);
      case 'ShareAttributeAcceptResponseItem':
        return ShareAttributeAcceptResponseItem.fromJson(json);
      case 'ProposeAttributeAcceptResponseItem':
        return ProposeAttributeAcceptResponseItem.fromJson(json);
      case 'ReadAttributeAcceptResponseItem':
        return ReadAttributeAcceptResponseItem.fromJson(json);
      case 'RegisterAttributeListenerAcceptResponseItem':
        return RegisterAttributeListenerAcceptResponseItem.fromJson(json);
      case 'SucceedAttributeAcceptResponseItem':
        return SucceedAttributeAcceptResponseItem.fromJson(json);
      default:
        throw Exception('Unknown type: $type');
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'AcceptResponseItem',
      };

  @override
  List<Object?> get props => [super.props];
}
