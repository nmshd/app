import 'identity_attribute_value.dart';

class AffiliationUnitAttributeValue extends IdentityAttributeValue {
  final String value;

  const AffiliationUnitAttributeValue({
    required this.value,
  });

  factory AffiliationUnitAttributeValue.fromJson(Map json) => AffiliationUnitAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'AffiliationUnit',
        'value': value,
      };

  @override
  String toString() => 'AffiliationUnitAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
