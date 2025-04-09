import 'package:json_annotation/json_annotation.dart';

import 'accept_response_item.dart';

part 'register_attribute_listener_accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class RegisterAttributeListenerAcceptResponseItem extends AcceptResponseItem {
  final String listenerId;

  const RegisterAttributeListenerAcceptResponseItem({required this.listenerId}) : super(atType: 'RegisterAttributeListenerAcceptResponseItem');

  factory RegisterAttributeListenerAcceptResponseItem.fromJson(Map json) =>
      _$RegisterAttributeListenerAcceptResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$RegisterAttributeListenerAcceptResponseItemToJson(this);

  @override
  List<Object?> get props => [super.props, listenerId];
}
