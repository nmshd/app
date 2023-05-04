import 'identity_attribute_value.dart';

class StateAttributeValue extends IdentityAttributeValue {
  final String value;

  const StateAttributeValue({
    required this.value,
  });

  factory StateAttributeValue.fromJson(Map json) => StateAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'State',
        'value': value,
      };

  @override
  String toString() => 'StateAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
