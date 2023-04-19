import 'identity_attribute_value.dart';

class Street extends IdentityAttributeValue {
  final String value;

  const Street({
    required this.value,
  });

  factory Street.fromJson(Map json) => Street(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Street',
        'value': value,
      };

  @override
  String toString() => 'Street(value: $value)';

  @override
  List<Object?> get props => [value];
}
