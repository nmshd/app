import 'identity_attribute_value.dart';

class Surname extends IdentityAttributeValue {
  final String value;

  const Surname({
    required this.value,
  });

  factory Surname.fromJson(Map json) => Surname(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Surname',
        'value': value,
      };

  @override
  String toString() => 'Surname(value: $value)';

  @override
  List<Object?> get props => [value];
}
