import 'identity_attribute_value.dart';

class Sex extends IdentityAttributeValue {
  final String value;

  const Sex({
    required this.value,
  });

  factory Sex.fromJson(Map<String, dynamic> json) => Sex(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Sex',
        'value': value,
      };

  @override
  String toString() => 'Sex(value: $value)';

  @override
  List<Object?> get props => [value];
}
