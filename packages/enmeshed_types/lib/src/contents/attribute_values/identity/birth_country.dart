import 'identity_attribute_value.dart';

class BirthCountry extends IdentityAttributeValue {
  final String value;

  const BirthCountry({
    required this.value,
  });

  factory BirthCountry.fromJson(Map json) => BirthCountry(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthCountry',
        'value': value,
      };

  @override
  String toString() => 'BirthCountry(value: $value)';

  @override
  List<Object?> get props => [value];
}
