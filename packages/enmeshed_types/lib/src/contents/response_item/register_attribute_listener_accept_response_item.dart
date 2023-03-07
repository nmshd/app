part of 'response_item.dart';

class RegisterAttributeListenerAcceptResponseItem extends AcceptResponseItem {
  final String listenerId;

  RegisterAttributeListenerAcceptResponseItem({
    required this.listenerId,
  });

  factory RegisterAttributeListenerAcceptResponseItem.fromJson(Map<String, dynamic> json) {
    return RegisterAttributeListenerAcceptResponseItem(
      listenerId: json['listenerId'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'RegisterAttributeListenerAcceptResponseItem',
        'listenerId': listenerId,
      };

  @override
  String toString() => 'RegisterAttributeListenerAcceptResponseItem(listenerId: $listenerId)';
}
