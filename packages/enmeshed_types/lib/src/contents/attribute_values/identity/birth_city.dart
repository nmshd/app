import 'identity_attribute_value.dart';

class BirthCity extends IdentityAttributeValue {
  final String value;

  const BirthCity({
    required this.value,
  });

  factory BirthCity.fromJson(Map json) => BirthCity(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthCity',
        'value': value,
      };

  @override
  String toString() => 'BirthCity(value: $value)';

  @override
  List<Object?> get props => [value];
}
