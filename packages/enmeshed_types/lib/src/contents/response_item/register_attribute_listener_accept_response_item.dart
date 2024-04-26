part of 'response_item.dart';

class RegisterAttributeListenerAcceptResponseItem extends AcceptResponseItem {
  final String listenerId;

  const RegisterAttributeListenerAcceptResponseItem({
    required this.listenerId,
  });

  factory RegisterAttributeListenerAcceptResponseItem.fromJson(Map json) {
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
  List<Object?> get props => [super.props, listenerId];
}
