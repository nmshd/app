import 'identity_attriube_value.dart';

class DisplayName extends IdentityAttributeValue {
  final String value;

  DisplayName({
    required this.value,
  });

  factory DisplayName.fromJson(Map<String, dynamic> json) => DisplayName(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'DisplayName',
        'value': value,
      };

  @override
  String toString() => 'DisplayName(value: $value)';
}
