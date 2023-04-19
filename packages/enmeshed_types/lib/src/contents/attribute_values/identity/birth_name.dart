import 'identity_attribute_value.dart';

class BirthName extends IdentityAttributeValue {
  final String value;

  const BirthName({
    required this.value,
  });

  factory BirthName.fromJson(Map json) => BirthName(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthName',
        'value': value,
      };

  @override
  String toString() => 'BirthName(value: $value)';

  @override
  List<Object?> get props => [value];
}
