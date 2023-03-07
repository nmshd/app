import 'identity_attriube_value.dart';

class StateAttribute extends IdentityAttributeValue {
  final String value;
  StateAttribute({
    required this.value,
  });

  factory StateAttribute.fromJson(Map<String, dynamic> json) => StateAttribute(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'State',
        'value': value,
      };

  @override
  String toString() => 'StateAttribute(value: $value)';
}
