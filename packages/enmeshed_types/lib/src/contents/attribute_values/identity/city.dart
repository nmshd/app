import 'identity_attribute_value.dart';

class City extends IdentityAttributeValue {
  final String value;

  const City({
    required this.value,
  });

  factory City.fromJson(Map json) => City(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'City',
        'value': value,
      };

  @override
  String toString() => 'City(value: $value)';

  @override
  List<Object?> get props => [value];
}
