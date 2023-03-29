import 'identity_attribute_value.dart';

class BirthState extends IdentityAttributeValue {
  final String value;

  const BirthState({
    required this.value,
  });

  factory BirthState.fromJson(Map<String, dynamic> json) => BirthState(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthState',
        'value': value,
      };

  @override
  String toString() => 'BirthState(value: $value)';

  @override
  List<Object?> get props => [value];
}
