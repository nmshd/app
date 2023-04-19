import 'identity_attribute_value.dart';

class Nationality extends IdentityAttributeValue {
  final String value;

  const Nationality({
    required this.value,
  });

  factory Nationality.fromJson(Map json) => Nationality(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Nationality',
        'value': value,
      };

  @override
  String toString() => 'Nationality(value: $value)';

  @override
  List<Object?> get props => [value];
}
