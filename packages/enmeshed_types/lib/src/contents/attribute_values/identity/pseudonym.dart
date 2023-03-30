import 'identity_attribute_value.dart';

class Pseudonym extends IdentityAttributeValue {
  final String value;

  const Pseudonym({
    required this.value,
  });

  factory Pseudonym.fromJson(Map<String, dynamic> json) => Pseudonym(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Pseudonym',
        'value': value,
      };

  @override
  String toString() => 'Pseudonym(value: $value)';

  @override
  List<Object?> get props => [value];
}
