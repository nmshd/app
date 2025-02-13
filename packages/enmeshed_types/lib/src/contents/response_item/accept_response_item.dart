part of 'response_item.dart';

class AcceptResponseItem extends ResponseItemDerivation {
  const AcceptResponseItem() : super(result: ResponseItemResult.Accepted);

  factory AcceptResponseItem.fromJson(Map json) {
    final type = json['@type'];

    if (type == 'AcceptResponseItem') return const AcceptResponseItem();

    return switch (type) {
      'CreateAttributeAcceptResponseItem' => CreateAttributeAcceptResponseItem.fromJson(json),
      'DeleteAttributeAcceptResponseItem' => DeleteAttributeAcceptResponseItem.fromJson(json),
      'ShareAttributeAcceptResponseItem' => ShareAttributeAcceptResponseItem.fromJson(json),
      'ProposeAttributeAcceptResponseItem' => ProposeAttributeAcceptResponseItem.fromJson(json),
      'ReadAttributeAcceptResponseItem' => ReadAttributeAcceptResponseItem.fromJson(json),
      'RegisterAttributeListenerAcceptResponseItem' => RegisterAttributeListenerAcceptResponseItem.fromJson(json),
      'FreeTextAcceptResponseItem' => FreeTextAcceptResponseItem.fromJson(json),
      'AttributeAlreadySharedAcceptResponseItem' => AttributeAlreadySharedAcceptResponseItem.fromJson(json),
      'AttributeSuccessionAcceptResponseItem' => AttributeSuccessionAcceptResponseItem.fromJson(json),
      _ => throw Exception('Unknown type: $type'),
    };
  }

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), '@type': 'AcceptResponseItem'};
}
