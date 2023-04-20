import 'identity_attribute_value.dart';

class GivenName extends IdentityAttributeValue {
  final String value;

  const GivenName({
    required this.value,
  });

  factory GivenName.fromJson(Map json) => GivenName(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'GivenName',
        'value': value,
      };

  @override
  String toString() => 'GivenName(value: $value)';

  @override
  List<Object?> get props => [value];
}
