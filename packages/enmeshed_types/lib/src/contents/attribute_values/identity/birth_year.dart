import 'identity_attribute_value.dart';

class BirthYear extends IdentityAttributeValue {
  final int value;

  const BirthYear({
    required this.value,
  });

  factory BirthYear.fromJson(Map<String, dynamic> json) => BirthYear(
        value: json['value'].toInt(),
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthYear',
        'value': value,
      };

  @override
  String toString() => 'BirthYear(value: $value)';

  @override
  List<Object?> get props => [value];
}
