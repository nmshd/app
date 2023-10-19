import 'identity_attribute_value.dart';

class PseudonymAttributeValue extends IdentityAttributeValue {
  final String value;

  const PseudonymAttributeValue({
    required this.value,
  }) : super('Pseudonym');

  factory PseudonymAttributeValue.fromJson(Map json) => PseudonymAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': super.atType,
        'value': value,
      };

  @override
  String toString() => 'PseudonymAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
