import 'identity_attribute_value.dart';

class Citizenship extends IdentityAttributeValue {
  final String value;

  const Citizenship({
    required this.value,
  });

  factory Citizenship.fromJson(Map<String, dynamic> json) => Citizenship(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Citizenship',
        'value': value,
      };

  @override
  String toString() => 'Citizenship(value: $value)';

  @override
  List<Object?> get props => [value];
}
