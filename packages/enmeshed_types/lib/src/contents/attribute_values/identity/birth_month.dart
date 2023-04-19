import 'identity_attribute_value.dart';

class BirthMonth extends IdentityAttributeValue {
  final int value;

  const BirthMonth({
    required this.value,
  });

  factory BirthMonth.fromJson(Map json) => BirthMonth(
        value: json['value'].toInt(),
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthMonth',
        'value': value,
      };

  @override
  String toString() => 'BirthMonth(value: $value)';

  @override
  List<Object?> get props => [value];
}
