import 'identity_attriube_value.dart';

class Website extends IdentityAttributeValue {
  final String value;
  Website({
    required this.value,
  });

  factory Website.fromJson(Map<String, dynamic> json) => Website(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Website',
        'value': value,
      };

  @override
  String toString() => 'Website(value: $value)';
}
