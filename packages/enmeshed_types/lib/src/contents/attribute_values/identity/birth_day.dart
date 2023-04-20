import 'identity_attribute_value.dart';

class BirthDay extends IdentityAttributeValue {
  final int value;

  const BirthDay({
    required this.value,
  });

  factory BirthDay.fromJson(Map json) => BirthDay(
        value: json['value'].toInt(),
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthDay',
        'value': value,
      };

  @override
  String toString() => 'BirthDay(value: $value)';

  @override
  List<Object?> get props => [value];
}
