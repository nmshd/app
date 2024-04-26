import 'identity_attribute_value.dart';

class StateAttributeValue extends IdentityAttributeValue {
  final String value;

  const StateAttributeValue({
    required this.value,
  }) : super('State');

  factory StateAttributeValue.fromJson(Map json) => StateAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': super.atType,
        'value': value,
      };

  @override
  List<Object?> get props => [value];
}
